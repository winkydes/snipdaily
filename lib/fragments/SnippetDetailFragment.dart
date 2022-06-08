import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:snipdaily/widgets/BackableAppBar.dart';

import '../backend/models.dart';

class SnippetDetailFragment extends StatefulWidget {

  final String id;

  const SnippetDetailFragment({Key? key, required this.id}) : super(key: key);

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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text("This is snippet details screen with id ${widget.id}"),
            ),
          ],
        ),
      )
    );
  }
}