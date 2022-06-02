import 'package:flutter/material.dart';

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
        appBar: AppBar(
          title: Row(
            children: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            const Text("Tell us more about your snippet!"),
          ],
          ),
          backgroundColor: const Color.fromARGB(255, 174, 123, 241),
        ),
        body: const Center(child: Text("This is snippet extra data fragment"),)
      )
    );
  }
}