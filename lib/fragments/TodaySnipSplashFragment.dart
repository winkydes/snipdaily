import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snipdaily/assets/constants.dart';
import '../backend/models.dart';
import '../main.dart';
import '../widgets/LanguageLabel.dart';
import '../widgets/TypeLabel.dart';

class TodaySnipSplashFragment extends StatefulWidget {
  const TodaySnipSplashFragment({Key? key}) : super(key: key);

  @override
  State<TodaySnipSplashFragment> createState() => _TodaySnipSplashFragmentState();
}

class _TodaySnipSplashFragmentState extends State<TodaySnipSplashFragment> {
  int day = DateTime.now().day.toInt();
  double customFontSize = 15;
  var db = FirebaseFirestore.instance;
  var currentUser = FirebaseAuth.instance.currentUser!;
  late final Stream<UserPref> userStream = db.collection("Users").where("uid", isEqualTo: currentUser.uid).snapshots().map((item) => UserPref.fromSnapshot(item.docs.first));
  late List<dynamic> languagePrefList = [];

  void updatePref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear(); //clear previous preferences
    prefs.setBool("login$day", false);
  }

  showInfoAlert() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          content: Text("The snippets suggested to you here are chosen according to your language preferences. If you did not choose any language as your preference, then any snippet could appear here. To change your language preferences, please go to the settings under your profile.")
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
        title: const Text("Today's Snippet!"),
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
              return ListView(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
                children: [
                  Text(
                    randomSnip.title,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        LanguageLabel(language: randomSnip.language),
                        TypeLabel(type: randomSnip.type),
                      ],
                    ),
                  ]),
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
                  ElevatedButton(
                    onPressed: () {
                      updatePref();
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginWidget()));
                    },
                    child: const Text("Continue")),
                ],
              );
            }
          );
        }
      )
    );
  }
}