import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:snipdaily/assets/constants.dart';
import '../../backend/models.dart';
import '../../widgets/AdminSnippetCardView.dart';

class AdminVerifySnippetFragment extends StatefulWidget {
  const AdminVerifySnippetFragment({Key? key}) : super(key: key);

  @override
  State<AdminVerifySnippetFragment> createState() => _AdminVerifySnippetFragmentState();
}

class _AdminVerifySnippetFragmentState extends State<AdminVerifySnippetFragment> {
  // take data from firebase in the form of Stream<Iterable<Snippet>>
  late final Stream<Iterable<Snippet>> _snippetStream = FirebaseFirestore
      .instance
      .collection('snippets')
      .where("verified", isEqualTo: NOT_VERIFIED)
      .snapshots()
      .map((item) => item.docs.map((doc) => Snippet.fromSnapshot(doc)));

  late final List<Widget> snippetList = [];

  // initialize snippetList for rendering in screen
  @override
  void initState() {
    _snippetStream.forEach((element) => {
          element.forEach((snip) => snippetList.add(AdminSnippetCardView(
                cardSnippet: snip,
              )))
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    'There are no snippets waiting for a review yet, please wait for an update to the database.',
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
