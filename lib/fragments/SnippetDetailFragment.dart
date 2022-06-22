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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        LanguageLabel(language: widget.snip.language),
                        TypeLabel(type: widget.snip.type),
                      ],
                    ),
                    // control font size button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.all(5),
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
                          margin: const EdgeInsets.all(5),
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
                  ]),
                  // code container
                  Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 20),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        color: Colors.grey[200]),
                    child: Text(widget.snip.code,
                        style: TextStyle(
                          fontSize: customFontSize,
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
                    )),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          "Do you find this snippet useful?",
                          style: Theme.of(context).textTheme.bodyMedium,
                        )
                      ),
                      Row(
                        children: [
                          IconButton(onPressed: () {}, icon: const Icon(Icons.thumb_up, size: 36, color: Colors.green,)),
                          IconButton(onPressed: () {}, icon: const Icon(Icons.thumb_down, size: 36, color: Colors.red,)),
                        ],
                      )
                    ],
                  )
                ],
            ));
          }
        });
  }
}
