import 'package:flutter/material.dart';

class FullContributionListFragment extends StatefulWidget {
  final List<Widget> fullList;
  const FullContributionListFragment({Key? key, required this.fullList}) : super(key: key);

  @override
  State<FullContributionListFragment> createState() => _FullContributionListFragmentState();
}

class _FullContributionListFragmentState extends State<FullContributionListFragment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("All contributions")),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 30, left: 35),
            child: const Text("Sort from newest to oldest")
          ),
          Padding(
            padding: const EdgeInsets.only(left:30, right: 30, bottom: 30),
            child: Column(
              children: widget.fullList,
            ),
          ),
        ],
      )
    );
  }
}