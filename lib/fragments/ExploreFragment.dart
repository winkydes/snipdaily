import 'package:flutter/material.dart';

class ExploreFragment extends StatefulWidget {
  const ExploreFragment({Key? key}) : super(key: key);

  @override
  State<ExploreFragment> createState() => _ExploreFragmentState();
}

class _ExploreFragmentState extends State<ExploreFragment> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Center(
          child: Text("This is home screen"),
        ),
      ],
    );
  }
}