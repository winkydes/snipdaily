import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:snipdaily/widgets/SnippetCardView.dart';

import '../backend/models.dart';

class SnippetListFragment extends StatefulWidget {
  const SnippetListFragment({Key? key}) : super(key: key);

  @override
  State<SnippetListFragment> createState() => _SnippetListFragmentState();
}
class _SnippetListFragmentState extends State<SnippetListFragment> {

  // take data from firebase in the form of Stream<Iterable<Snippet>>
  late final Stream<Iterable<Snippet>> _snippetStream = FirebaseFirestore.instance.collection('snippets').snapshots().map((item) => item.docs.map((doc) => Snippet.fromSnapshot(doc)));

  late final List<Widget> snippetList = [];

  // initialize snippetList for rendering in screen
  @override
  void initState() {
    _snippetStream.forEach((element) => { 
      element.forEach((snip) => snippetList.add(SnippetCardView(cardSnippet: snip,)))
     });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<Iterable<Snippet>>(
      stream: _snippetStream,
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
        return ListView(
          padding: const EdgeInsets.only(left: 30, right: 30, top: 30, bottom: 30),
          children: snippetList
        );
      }
    );
  }
}