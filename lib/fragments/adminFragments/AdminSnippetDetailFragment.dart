import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:snipdaily/fragments/adminFragments/adminHomeFragment.dart';
import '../../assets/constants.dart';
import '../../backend/models.dart';
import '../../widgets/LanguageLabel.dart';
import '../../widgets/TypeLabel.dart';

var db = FirebaseFirestore.instance;

class AdminSnippetDetailFragment extends StatefulWidget {
  final Snippet snip;

  const AdminSnippetDetailFragment({Key? key, required this.snip}) : super(key: key);

  @override
  State<AdminSnippetDetailFragment> createState() => _AdminSnippetDetailFragmentState();
}

class _AdminSnippetDetailFragmentState extends State<AdminSnippetDetailFragment> {

  double customFontSize = 15;

  resize(bool larger) {
    if (larger && customFontSize < 30) {
      setState(() {
        customFontSize = customFontSize + 5;
      });
    }
    else if (!larger && customFontSize > 10) {
      setState(() {
        customFontSize = customFontSize - 5;
      });
    }
  }

  Future<void> verifySnippet(bool pass, String docId) async {
    if (pass) {
      db.collection('snippets').doc(docId).update({"verified": VERIFIED});
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AdminHomeFragment())
      );
    }
    else {
      db.collection('snippets').doc(docId).update({"verified": REJECTED});
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AdminHomeFragment())
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
        .collection('Users')
        .where("uid", isEqualTo: widget.snip.authorId)
        .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          var author = snapshot.data!.docs.first['displayName'];
          return Scaffold(
            appBar: AppBar(title: const Text("Details")),
            body: ListView(
              padding: const EdgeInsets.only(
                left: 20, right: 20, top: 20, bottom: 20),
                children: [
                  // title container
                  Text(
                    widget.snip.title,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  // author container
                  Container(
                    alignment: Alignment.centerRight,
                    margin: const EdgeInsets.only(right: 10, bottom: 10),
                    child: Text("-- by $author", style: Theme.of(context).textTheme.bodySmall)),
                  // label container
                  Row(children: <Widget>[
                    LanguageLabel(language: widget.snip.language),
                    TypeLabel(type: widget.snip.type),
                  ]),
                  // code container
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        color: Colors.grey[200]),
                    child: Text(widget.snip.code,
                        style: TextStyle(
                          fontSize: customFontSize,
                          fontFamily: 'Consolas',
                        ))),
                  // control font size button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.all(10),
                        child: Ink(
                            decoration: ShapeDecoration(
                              shape: const CircleBorder(),
                              color: Colors.grey[200]),
                            child: InkWell(
                              onTap: () {
                                resize(false);
                              },
                              child: const Icon(Icons.remove, size: 36))),
                      ),
                      Container(
                        margin: const EdgeInsets.all(10),
                        child: Ink(
                            decoration: ShapeDecoration(
                              shape: const CircleBorder(),
                              color: Colors.grey[200]),
                            child: InkWell(
                              onTap: () {
                                resize(true);
                              },
                              child: const Icon(Icons.add, size: 36))),
                      ),
                    ],
                  ),
                  // description container
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      color: Colors.white),
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      widget.snip.description,
                      style: const TextStyle(fontSize: 18.0, height: 1.5),
                    )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.all(10),
                        child: Ink(
                            decoration: ShapeDecoration(
                              shape: const CircleBorder(),
                              color: Colors.green[300]),
                            child: InkWell(
                              onTap: () {
                                verifySnippet(true, widget.snip.id);
                              },
                              child: const Icon(Icons.check, size: 36))),
                      ),
                      Container(
                        margin: const EdgeInsets.all(10),
                        child: Ink(
                            decoration: ShapeDecoration(
                              shape: const CircleBorder(),
                              color: Colors.red[300]),
                            child: InkWell(
                              onTap: () {
                                verifySnippet(false, widget.snip.id);
                              },
                              child: const Icon(Icons.cancel, size: 36))),
                      ),
                    ],
                  ),
                ],
            ));
          }
        });
  }
}