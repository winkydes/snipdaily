import 'package:flutter/material.dart';
import '../widgets/DropdownWidget.dart';

class AddSnippetFragment extends StatefulWidget {
  const AddSnippetFragment({Key? key}) : super(key: key);

  @override
  State<AddSnippetFragment> createState() => _AddSnippetFragmentState();
}

class _AddSnippetFragmentState extends State<AddSnippetFragment> {
  
  var languageDropdownItems = [ "C++", "JavaScript", "Python"];

  @override
  Widget build(BuildContext context) {
    return ListView(
        padding:
            const EdgeInsets.only(left: 30, right: 30, top: 30, bottom: 30),
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: const Text("Please choose a language to start with:"),
          ),
          DropdownWidget(
            dropdownList: languageDropdownItems,
          )
        ]);
  }
}
