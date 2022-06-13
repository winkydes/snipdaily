import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:snipdaily/widgets/BackableAppBar.dart';

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
    return MaterialApp(
      home: Scaffold(
          appBar: BackableAppBar(
            title: const Text("Details"),
            appBar: AppBar(),
            widgets: const [],
            pageContext: context,
          ),
          body: ListView(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
            children: [
              // title container
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: 
                  Text(
                    widget.snip.title,
                    style: Theme.of(context).textTheme.headline5,
                  ),
              ),
              // label container
              Row(
                children: <Widget>[
                  LanguageLabel(language: widget.snip.language),
                  TypeLabel(type: widget.snip.type),
                ]
              ),
              
              // code container
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: const Color.fromARGB(255, 202, 202, 202)
                ),
                child: Text(widget.snip.code, style: const TextStyle(
                  fontSize: 20,
                  fontFamily: 'Consolas',
                  ))
              ),
              // description container
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: const Color.fromARGB(255, 202, 202, 202)
                ),
                padding: const EdgeInsets.all(10),
                child: Text(widget.snip.description, style: const TextStyle(fontSize: 18.0,height: 1.5),
                )
              )
            ],
          )),
    );
  }
}
