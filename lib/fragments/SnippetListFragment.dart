import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:snipdaily/assets/constants.dart';
import 'package:snipdaily/widgets/SnippetCardView.dart';
import '../backend/models.dart';

class SnippetListFragment extends StatefulWidget {
  final String type;
  const SnippetListFragment({Key? key, required this.type}) : super(key: key);

  @override
  State<SnippetListFragment> createState() => _SnippetListFragmentState();
}

class _SnippetListFragmentState extends State<SnippetListFragment> {
  // take data from firebase in the form of Stream<Iterable<Snippet>>
  late final Stream<Iterable<Snippet>> _snippetStream = FirebaseFirestore
      .instance
      .collection('snippets')
      .where("type", isEqualTo: widget.type) 
      .where("verified", isEqualTo: VERIFIED)
      .snapshots()
      .map((item) => item.docs.map((doc) => Snippet.fromSnapshot(doc)));

  late final List<Widget> snippetList = [];

  // initialize snippetList for rendering in screen
  @override
  void initState() {
    _snippetStream.forEach((element) => {
          element.forEach((snip) => snippetList.add(SnippetCardView(
                cardSnippet: snip,
              )))
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.type)),
        body: StreamBuilder<Iterable<Snippet>>(
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
              if (snippetList.isEmpty) {
                return const Center(
                  child: Text(
                    'There is no snippets related to this topic yet, please wait for an update to the database.',
                    textAlign: TextAlign.center,
                  ),
                );
              }
              return ListView(
                  padding: const EdgeInsets.only(
                      left: 30, right: 30, top: 30, bottom: 30),
                  children: snippetList);
            }),
      
    );
  }
}
