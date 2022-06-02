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

  // This is the text field or image widget depending on the value in formatDropdownItems
  Widget getFormatWidget() {
    if (formatValue == "Text") {
      return Container(
        margin: const EdgeInsets.only(top: 20, bottom: 20),
        child: const TextField(
          decoration: InputDecoration(
            labelText: "Your code snippet",
            fillColor: Colors.white,
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1.0)
              ),
          ),
          maxLines: 8,
        ),
      );
    }
    else if (formatValue == "Image") {
      return Container(
        margin: const EdgeInsets.all(20),
        child: const Center(
          child: Text("Image box (Currently Unsupported)"),
        )
      );
    }
    else {
      return const SizedBox.shrink();
    }
  }

  Widget submitButton() {
    if (languageValue == "Select" || formatValue == "Select") {
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
            MaterialPageRoute(builder: (context) => const SnippetExtraDataFragment())
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
          getFormatWidget(),
          submitButton(),
        ]);
  }
}
