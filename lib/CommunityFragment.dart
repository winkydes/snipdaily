import 'package:flutter/material.dart';

class CommunityFragment extends StatefulWidget {
  const CommunityFragment({Key? key}) : super(key: key);

  @override
  State<CommunityFragment> createState() => _CommunityFragmentState();
}

class _CommunityFragmentState extends State<CommunityFragment> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Center(
          child: Text("This is community screen"),
        ),
      ],
    );
  }
}