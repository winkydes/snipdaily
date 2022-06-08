import 'package:flutter/material.dart';
import 'package:snipdaily/widgets/SnippetCardView.dart';

class ExploreFragment extends StatefulWidget {
  const ExploreFragment({Key? key}) : super(key: key);

  @override
  State<ExploreFragment> createState() => _ExploreFragmentState();
}
class _ExploreFragmentState extends State<ExploreFragment> {
  @override
  Widget build(BuildContext context) {
    return ListView(
        padding:
            const EdgeInsets.only(left: 30, right: 30, top: 30, bottom: 30),
        children: const <Widget> [
          SnippetCardView(
              title: "",
              language: "Test Language",
              author: "Keith"
          ),
        ]);
  }
}
