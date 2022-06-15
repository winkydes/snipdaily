import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../backend/models.dart';
import '../widgets/LanguageLabel.dart';
import '../widgets/TypeLabel.dart';

class SnippetDetailFragment extends StatefulWidget {
  final Snippet snip;

  const SnippetDetailFragment({Key? key, required this.snip}) : super(key: key);

  @override
  State<SnippetDetailFragment> createState() => _SnippetDetailFragmentState();
}

class _SnippetDetailFragmentState extends State<SnippetDetailFragment> {
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
                      child: Text("-- by $author",
                          style: Theme.of(context).textTheme.bodySmall)),
                  // label container
                  Row(children: <Widget>[
                    LanguageLabel(language: widget.snip.language),
                    TypeLabel(type: widget.snip.type),
                  ]),

                  // code container
                  Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          color: Colors.grey[200]),
                      child: Text(widget.snip.code,
                          style: const TextStyle(
                            fontSize: 15,
                            fontFamily: 'Consolas',
                          ))),
                  // description container
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          color: Colors.white),
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        widget.snip.description,
                        style: const TextStyle(fontSize: 18.0, height: 1.5),
                      ))
                ],
              ));
          }
          
        });
  }
}
