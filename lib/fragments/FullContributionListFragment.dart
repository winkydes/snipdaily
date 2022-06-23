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
        padding: const EdgeInsets.all(30),
        children: widget.fullList,
      )
    );
  }
}