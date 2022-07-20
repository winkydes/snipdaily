import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';

var db = FirebaseFirestore.instance;
class AddTopicFragment extends StatefulWidget {
  const AddTopicFragment({Key? key}) : super(key: key);

  @override
  State<AddTopicFragment> createState() => _AddTopicFragmentState();
}

class _AddTopicFragmentState extends State<AddTopicFragment> {

  final topicController = TextEditingController();
  final contentController = TextEditingController();

  void submitContent() {
    if (topicController.text == '' || contentController.text =='') {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: Text("Some fields are missing, please try again."),
          );
        },
      );
    } else {
      final topic = <String, dynamic> {
        "title": topicController.text,
        "contributorId": FirebaseAuth.instance.currentUser!.uid,
      };
      db.collection("topics").add(topic).then((DocumentReference doc) {
        final firstMessage = <String, dynamic> {
        "userId": FirebaseAuth.instance.currentUser!.uid,
        "content": contentController.text,
        "topicId": doc.id,
        "time": DateTime.now(),
        };
        db.collection("topics").doc(doc.id).collection("message").add(firstMessage);
      });
      Navigator.pushNamedAndRemoveUntil(context,'/', (_) => false);
    }
  }

  @override
  void dispose() {
    topicController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create a new topic!"),
        leading: IconButton(icon: const Icon(Icons.close), onPressed: () { Navigator.pop(context); },),
        actions: [
          TextButton(
            onPressed: () { submitContent(); },
            child: const Text("Submit", style: TextStyle(color: Colors.lightBlue)),
          ),
        ],
      ),
      body: ListView(
        children: [
          // user label container
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(top: 20, left: 30, right: 30),
            child: Row(
              children: [
                ProfilePicture(name: FirebaseAuth.instance.currentUser!.displayName!, radius: 17, fontsize: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        FirebaseAuth.instance.currentUser!.displayName!,
                        style: const TextStyle(fontSize: 17)),
                      Text(
                        "${DateTime.now().year.toString()}-${DateTime.now().month.toString().padLeft(2,'0')}-${DateTime.now().day.toString().padLeft(2,'0')}",
                        style: const TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          // title input container
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
            child: TextField(
              minLines: 1,
              maxLines: 3,
              controller: topicController,
              decoration: const InputDecoration(
                fillColor: Colors.transparent,
                filled: true,
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintText: "Title"
              ),
              style: const TextStyle(fontSize: 25),
            )
          ),
          // content input container
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: TextField(
              maxLines: null,
              controller: contentController,
              decoration: const InputDecoration(
                fillColor: Colors.transparent,
                filled: true,
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintText: "Content..."
              ),
            )
          )
        ],
      ),
    );
  }
}