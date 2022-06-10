import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:snipdaily/widgets/BackableAppBar.dart';
import 'package:snipdaily/widgets/InputTextField.dart';

import '../HomeScreen.dart';

var db = FirebaseFirestore.instance;
class SnippetExtraDataFragment extends StatefulWidget {
  final String language;
  final String format;

  const SnippetExtraDataFragment(
      {Key? key, required this.language, required this.format})
      : super(key: key);

  @override
  State<SnippetExtraDataFragment> createState() =>
      _SnippetExtraDataFragmentState();
}

class _SnippetExtraDataFragmentState extends State<SnippetExtraDataFragment> {

  final snippetController = TextEditingController();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  // This is the text field or image widget depending on the value in formatDropdownItems
  Widget getFormatWidget() {
    if (widget.format == "Text") {
      return InputTextField(
        maxLines: 6, 
        hintText: "Your Code Snippet",
        getTextController: snippetController);
    } else if (widget.format == "Image") {
      return Container(
          margin: const EdgeInsets.all(20),
          child: const Center(
            child: Text("Image box (Currently Unsupported)"),
          ));
    } else {
      return const SizedBox.shrink();
    }
  }

  void checkInput() {
    if (snippetController.text == "" || titleController.text == "" || descriptionController.text == "") {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: Text("Some fields are missing, please try again."),
          );
        },
      );
    }
    else {
      final snippet = <String, dynamic> {
        "code": snippetController.text,
        "language": widget.language,
        "formatType": widget.format,
        "title": titleController.text,
        "description": descriptionController.text,
      };
      db.collection("snippets").add(snippet).then((DocumentReference doc) => print("DocumentSnapshot added with ID: ${doc.id}"));
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen(isAdmin: false)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: BackableAppBar(
              title: const Text("Tell us more about your snippet!"),
              appBar: AppBar(),
              widgets: const [],
              pageContext: context,
            ),
            body: Center(
                child: ListView(
                    padding: const EdgeInsets.only(
                        left: 30, right: 30, top: 30, bottom: 30),
                    children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Text(
                      'Please place your code below:',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  getFormatWidget(),
                  Container(
                    margin: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Text(
                      'Title of this code snippet?',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  InputTextField(
                    maxLines: 1, 
                    hintText: "Title",
                    getTextController: titleController),
                  Container(
                    margin: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Text(
                      'Can you describe what does the snippet do?',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  InputTextField(
                    maxLines: 6, 
                    hintText: "Description",
                    getTextController: descriptionController),
                  Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.all(20),
                      child: ElevatedButton(
                        onPressed: () {
                          checkInput();
                        },
                        child: const Text("Submit"),
                      ))
                ]))));
  }
}
