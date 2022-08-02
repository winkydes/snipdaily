import 'package:flutter/material.dart';

import '../widgets/ProfileSnippetCardView.dart';

class FullContributionListFragment extends StatefulWidget {
  final List<ProfileSnippetCardView> fullList;
  const FullContributionListFragment({Key? key, required this.fullList}) : super(key: key);

  @override
  State<FullContributionListFragment> createState() => _FullContributionListFragmentState();
}

class _FullContributionListFragmentState extends State<FullContributionListFragment> {
  
  String sortType = 'newest';

  List<ProfileSnippetCardView> sortByDate(List<ProfileSnippetCardView> snipList) {
    snipList.sort((a, b) => b.cardSnippet.date.compareTo(a.cardSnippet.date));
    return snipList;
  }

  List<ProfileSnippetCardView> sortByPopularity(List<ProfileSnippetCardView> snipList) {
    snipList.sort((a, b) => b.cardSnippet.liked.length.compareTo(a.cardSnippet.liked.length));
    return snipList;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("All contributions")),
      body: ListView(
        children: [
          GestureDetector(
            onTap: () {
              if (sortType == 'trending') {
                setState(() {
                  sortType = 'newest';
                });
              } else {
                setState(() {
                  sortType = 'trending';
                });
              }
              
            },
            child: Container(
              margin: const EdgeInsets.only(top: 30, left: 35),
              child: Text(sortType == 'trending' ? "Sort by popularity": "Sort from newest to oldest", style: const TextStyle(fontWeight: FontWeight.bold),)
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left:30, right: 30, bottom: 30),
            child: Column(
              children: sortType == 'trending' ? sortByPopularity(widget.fullList): sortByDate(widget.fullList),
            ),
          ),
        ],
      )
    );
  }
}