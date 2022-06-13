import 'package:flutter/material.dart';
import 'package:snipdaily/fragments/SnippetExtraDataFragment.dart';
import '../widgets/DropdownWidget.dart';

class AddSnippetFragment extends StatefulWidget {
  const AddSnippetFragment({Key? key}) : super(key: key);

  @override
  State<AddSnippetFragment> createState() => _AddSnippetFragmentState();
}

class _AddSnippetFragmentState extends State<AddSnippetFragment> {

  var languageDropdownItems = [ "C++", "JavaScript", "Python"];
  String languageValue = "Select";
  var formatDropdownItems = [ "Text", "Image" ];
  String formatValue = "Select";
  var snippetTypeDropdownItems = ["General", "Data Structure", "Web/app Development", "Data Science", "Algorithms and Logic", "Articles"];
  String typeValue = "Select";

  Widget submitButton() {
    if (languageValue == "Select" || formatValue == "Select" || typeValue == "Select") {
      return Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(20),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.red[200]
          ),
          onPressed: () {},
          child: const Text("Fields are missing")
        )
      );
    }
    else {
      return Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(20),
        child: ElevatedButton(
          onPressed: () { Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SnippetExtraDataFragment(language: languageValue, format: formatValue, type: typeValue))
          ); },
          child: const Text("Proceed"),
        )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
        padding:
            const EdgeInsets.only(left: 30, right: 30, top: 30, bottom: 30),
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: Text(
              'Please select a language to start with:',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          DropdownWidget(
            dropdownList: languageDropdownItems,
            callback: (val) => setState(() => languageValue = val)
          ),
          Container(
            margin: const EdgeInsets.only(top: 20, bottom: 20),
            child: Text(
              'Which format do you want to display your code snippet?',
              style: Theme.of(context).textTheme.bodyText1,
            )
          ),
          DropdownWidget(
            dropdownList: formatDropdownItems,
            callback: (val) => setState(() => formatValue = val)
          ),
          Container(
            margin: const EdgeInsets.only(top: 20, bottom: 20),
            child: Text(
              'What is the category of the code snippet?',
              style: Theme.of(context).textTheme.bodyText1,
            )
          ),
          DropdownWidget(
            dropdownList: snippetTypeDropdownItems,
            callback: (val) => setState(() => typeValue = val)
          ),
          submitButton(),
        ]);
  }
}
