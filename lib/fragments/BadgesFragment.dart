import 'package:flutter/material.dart';

class BadgesFragment extends StatefulWidget {
  const BadgesFragment({Key? key}) : super(key: key);

  @override
  State<BadgesFragment> createState() => _BadgesFragmentState();
}

class _BadgesFragmentState extends State<BadgesFragment> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Center(
          child: Text("This is badges screen"),
        ),
      ],
    );
  }
}