import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../backend/models.dart';
import 'ProfileSnippetCardView.dart';

class RecentContributionSummaryBox extends StatefulWidget {
  final String targetUid;
  const RecentContributionSummaryBox({Key? key, required this.targetUid}) : super(key: key);

  @override
  State<RecentContributionSummaryBox> createState() => _RecentContributionSummaryBoxState();
}

class _RecentContributionSummaryBoxState extends State<RecentContributionSummaryBox> {

  // take data from firebase in the form of Stream<Iterable<Snippet>>
  late final Stream<Iterable<Snippet>> _snippetStream = FirebaseFirestore
      .instance
      .collection('snippets')
      .where("authorId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .snapshots()
      .map((item) => item.docs.map((doc) => Snippet.fromSnapshot(doc)));

  late final List<Widget> snippetList = [];

  // initialize snippetList for rendering in screen
  @override
  void initState() {
    _snippetStream.forEach((element) => {
          element.forEach((snip) => snippetList.add(ProfileSnippetCardView(
                cardSnippet: snip,
              )))
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
        if (snippetList.isEmpty) {
          return Center(
            child: Text(
              widget.targetUid,
              textAlign: TextAlign.center,
            ),
          );
        }
        return Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: snippetList,
          ),
        );
      }
    );
  }
}