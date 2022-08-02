import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:snipdaily/widgets/SnippetCardView.dart';
import '../backend/models.dart';
import '../fragments/FullContributionListFragment.dart';
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
      .where("authorId", isEqualTo: widget.targetUid)
      .snapshots()
      .map((item) => item.docs.map((doc) => Snippet.fromSnapshot(doc)));

  late final List<Snippet> snippetList = [];
  late final List<ProfileSnippetCardView> snippetWidgetList = [];

  List<ProfileSnippetCardView> sortedSnippetSubList(List<Snippet> list) {
    list.sort((a, b) => b.date.compareTo(a.date));
    for (var snip in list) {
      snippetWidgetList.add(ProfileSnippetCardView(
      cardSnippet: snip,
    ));
    }
    if (list.length < 3) {
      return snippetWidgetList;
    } else {
      return snippetWidgetList.sublist(0, 3);
    }
  }

  // initialize snippetList for rendering in screen
  @override
  void initState() {
    _snippetStream.forEach((element) => {
      element.forEach((snip) => snippetList.add(snip))
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
          return const Center(
            child: Text(
              "This person did not upload any snippets yet",
              textAlign: TextAlign.center,
            ),
          );
        }
        return Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: sortedSnippetSubList(snippetList),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.only(right: 30),
              child: TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => FullContributionListFragment(fullList: snippetWidgetList)));
                },
                child: const Text("See more",)
              )
            )
          ],
        );
      }
    );
  }
}