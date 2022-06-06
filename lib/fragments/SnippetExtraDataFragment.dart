import 'package:flutter/material.dart';
import 'package:snipdaily/widgets/BackableAppBar.dart';

class SnippetExtraDataFragment extends StatefulWidget {
  const SnippetExtraDataFragment({Key? key}) : super(key: key);

  @override
  State<SnippetExtraDataFragment> createState() => _SnippetExtraDataFragmentState();
}

class _SnippetExtraDataFragmentState extends State<SnippetExtraDataFragment> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: BackableAppBar(
          title: const Text("Tell us more about your snippet!"),
          appBar: AppBar(),
          widgets: const [],
        ),
        body: const Center(child: Text("This is snippet extra data fragment"),)
      )
    );
  }
}