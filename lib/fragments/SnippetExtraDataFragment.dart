import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:snipdaily/assets/constants.dart';
import 'package:snipdaily/widgets/InputTextField.dart';

var db = FirebaseFirestore.instance;

class SnippetExtraDataFragment extends StatefulWidget {
  final String language;
  final String type;

  const SnippetExtraDataFragment(
      {Key? key,
      required this.language,
      required this.type})
      : super(key: key);

  @override
  State<SnippetExtraDataFragment> createState() =>
      _SnippetExtraDataFragmentState();
}

class _SnippetExtraDataFragmentState extends State<SnippetExtraDataFragment> {
  final snippetController = TextEditingController();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  void checkInput() {
    if (snippetController.text == "" ||
        titleController.text == "" ||
        descriptionController.text == "") {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: Text("Some fields are missing, please try again."),
          );
        },
      );
    } else {
      final snippet = <String, dynamic>{
        "code": snippetController.text,
        "language": widget.language,
        "title": titleController.text,
        "description": descriptionController.text,
        "type": widget.type,
        "authorId": FirebaseAuth.instance.currentUser!.uid,
        "verified": NOT_VERIFIED,
        "date": DateTime.now(),
      };
      db.collection("snippets").add(snippet);
      Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Tell us more about your snippet!")),
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
              InputTextField(
                maxLines: 6,
                hintText: "Your Code Snippet",
                getTextController: snippetController),
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
            ])));
  }
}
