import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../backend/models.dart';
import '../widgets/MessageBox.dart';

var db = FirebaseFirestore.instance;

class ChatroomFragment extends StatefulWidget {
  final Topic topic;
  const ChatroomFragment({Key? key, required this.topic}) : super(key: key);

  @override
  State<ChatroomFragment> createState() => _ChatroomFragmentState();
}

class _ChatroomFragmentState extends State<ChatroomFragment> {
  final messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.topic.title)),
      body: StreamBuilder<QuerySnapshot>(
          stream: db
              .collection('topics')
              .doc(widget.topic.id)
              .collection('message')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            List<Message> messageList = snapshot.data!.docs
              .map((DocumentSnapshot doc) {
                return Message.fromSnapshot(doc);
              })
              .toList();
            messageList.sort((a, b) => a.time.compareTo(b.time));
            if (snapshot.hasError) {
              return const Center(
                child: Text('Something went wrong'),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Stack(
              children: <Widget>[
                ListView(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
                  children: messageList
                      .map((e) => MessageBox(message: e))
                      .toList(),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    padding:
                        const EdgeInsets.only(left: 10, bottom: 10, top: 10),
                    height: 60,
                    width: double.infinity,
                    child: Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: Colors.lightBlue,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: TextField(
                            controller: messageController,
                            decoration: const InputDecoration(
                                hintText: "Write message...",
                                border: InputBorder.none),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: FloatingActionButton(
                            onPressed: () {
                              if (messageController.text != '') {
                                final message = <String, dynamic>{
                                  "userId":
                                      FirebaseAuth.instance.currentUser!.uid,
                                  "content": messageController.text,
                                  "topicId": widget.topic.id,
                                  "time": DateTime.now(),
                                };
                                db
                                    .collection('topics')
                                    .doc(widget.topic.id)
                                    .collection('message')
                                    .add(message);
                                messageController.text = '';
                              }
                            },
                            backgroundColor: Colors.blue,
                            elevation: 0,
                            child: const Icon(
                              Icons.send,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          }),
    );
  }
}
