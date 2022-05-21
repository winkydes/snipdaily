import 'package:flutter/material.dart';

class AskFragment extends StatefulWidget {
  const AskFragment({Key? key}) : super(key: key);

  @override
  State<AskFragment> createState() => _AskFragmentState();
}

class _AskFragmentState extends State<AskFragment> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Center(
          child: Text("This is ask screen"),
        ),
      ],
    );
  }
}