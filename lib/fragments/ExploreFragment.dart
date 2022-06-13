import 'package:flutter/material.dart';

import 'SnippetListFragment.dart';

class ExploreFragment extends StatefulWidget {
  const ExploreFragment({Key? key}) : super(key: key);

  @override
  State<ExploreFragment> createState() => _ExploreFragmentState();
}

GestureDetector customContainer(String type, Color? cardColor, BuildContext context) {
  return GestureDetector(
    onTap: (() => Navigator.push(context,
        MaterialPageRoute(builder: (context) => SnippetListFragment(type: type)))),
    child: Container(
      padding: const EdgeInsets.all(8),
      color: cardColor,
      child: Center(child: Text(type, textAlign: TextAlign.center,)),
    ),
  );
}

class _ExploreFragmentState extends State<ExploreFragment> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      primary: false,
      padding: const EdgeInsets.all(30),
      crossAxisSpacing: 20,
      mainAxisSpacing: 20,
      crossAxisCount: 2,
      children: <Widget>[
        customContainer('General', Colors.teal[200], context),
        customContainer('Data Structure', Colors.teal[200], context),
        customContainer('Web/App Development', Colors.teal[200], context),
        customContainer('Data Science', Colors.teal[200], context),
        customContainer('Algorithms and Logic', Colors.teal[200], context),
        customContainer('Articles', Colors.teal[200], context),
      ],
    );
  }
}
