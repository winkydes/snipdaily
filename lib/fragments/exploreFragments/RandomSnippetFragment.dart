import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:snipdaily/assets/constants.dart';
import '../../backend/models.dart';
import '../../widgets/LanguageLabel.dart';
import '../../widgets/TypeLabel.dart';
import '../OtherProfileFragment.dart';

class RandomSnippetFragment extends StatefulWidget {
  const RandomSnippetFragment({Key? key}) : super(key: key);

  @override
  State<RandomSnippetFragment> createState() => _RandomSnippetFragmentState();
}

class _RandomSnippetFragmentState extends State<RandomSnippetFragment> {

  double customFontSize = 15;
  var db = FirebaseFirestore.instance;
  var currentUser = FirebaseAuth.instance.currentUser!;
  late final Stream<UserPref> userStream = db.collection("Users").where("uid", isEqualTo: currentUser.uid).snapshots().map((item) => UserPref.fromSnapshot(item.docs.first));
  late List<dynamic> languagePrefList = [];

  showInfoAlert() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: const Text("The snippets suggested to you here are chosen according to your language preferences. If you did not choose any language as your preference, then any snippet could appear here. To change your language preferences, please go to the settings under your profile."),
          actions: [
            TextButton(onPressed: () {Navigator.pushNamed(context, '/pref');}, child: const Text("Go to language preference")),
          ],
        );
      }
    );
  }

  @override
  void initState() {
    userStream.forEach((element) {
      languagePrefList = element.languagePrefs;
    });
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Random Snippet!"),
        actions: [
          IconButton(onPressed: () {showInfoAlert();}, icon: const Icon(Icons.info_outline))
        ],
      ),
      body: StreamBuilder<UserPref>(
        stream: userStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Something went wrong'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (languagePrefList.isEmpty) {
            languagePrefList = LANGUAGE;
          }
          return StreamBuilder<Iterable<Snippet>>(
            stream: FirebaseFirestore.instance
              .collection('snippets')
              .where('language', whereIn: languagePrefList)
              .where('verified', isEqualTo: VERIFIED)
              .snapshots()
              .map((item) => item.docs.map((doc) => Snippet.fromSnapshot(doc))),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              // shuffling snippet list to get a random snippet
              List<Snippet> randomSnippetList = snapshot.data!.toList();
              randomSnippetList.shuffle();
              Snippet randomSnip = randomSnippetList.first;
              return StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                  .collection('Users')
                  .where("uid", isEqualTo: randomSnip.authorId)
                  .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    var author = snapshot.data!.docs.isEmpty? 'Deleted User' : snapshot.data!.docs.first['displayName'];
                    return ListView(
                      padding: const EdgeInsets.all(20),
                      children: [
                        // title container
                        Text(
                          randomSnip.title,
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        // author and date container
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 5, bottom: 5),
                              child: Text(randomSnip.date == DateTime.parse('0000-00-00 00:00:00Z')? 'Date not available': "${randomSnip.date.year.toString()}-${randomSnip.date.month.toString().padLeft(2,'0')}-${randomSnip.date.day.toString().padLeft(2,'0')}", style: Theme.of(context).textTheme.bodyMedium),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 5),
                              child: GestureDetector(
                                onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => OtherProfileFragment(authorId: randomSnip.authorId,)));},
                                child: Text("---- by $author", style: Theme.of(context).textTheme.bodyMedium)
                              )
                            ),
                          ],
                        ),
                        // label container
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              LanguageLabel(language: randomSnip.language),
                              TypeLabel(type: randomSnip.type),
                            ],
                          ),
                        ),
                        Card(
                          child: Container(
                            margin: const EdgeInsets.only(top: 10, bottom: 20),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: Text(randomSnip.code,
                              style: TextStyle(
                                fontSize: customFontSize,
                                fontFamily: 'Consolas',
                              ))),
                        ),
                        Card(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              randomSnip.description,
                              style: const TextStyle(fontSize: 18.0, height: 1.5),
                            )),
                        ),
                      ],
                    );
                  }
                }
              );
            }
          );
        }
      )
    );
  }
}