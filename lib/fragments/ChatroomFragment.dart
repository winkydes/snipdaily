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
  var listViewScrollController = ScrollController();

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
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError || snapshot.data == null) {
              return const Center(
                child: Text('Something went wrong'),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            List<Message> messageList = snapshot.data!.docs
              .map((DocumentSnapshot doc) {
                return Message.fromSnapshot(doc);
              })
              .toList();
            messageList.sort((a, b) => a.time.compareTo(b.time));
            return Stack(
              children: <Widget>[
                // messages
                ListView(
                  controller: listViewScrollController,
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 60),
                  children: messageList
                      .map((e) {
                        bool firstMsg = messageList.indexOf(e) == 0? true : messageList.elementAt(messageList.indexOf(e) - 1).time.day != e.time.day;
                        return MessageBox(message: e, isFirstMsgOfDay: firstMsg,);
                      })
                      .toList(),
                ),
                // bottom chat bar
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    color: Colors.white,
                    padding:
                        const EdgeInsets.only(bottom: 10, top: 10),
                    width: double.infinity,
                    child: Row(
                      children: <Widget>[
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          reverse: true,
                            child: TextField(
                              onTap: () {
                                Future.delayed(const Duration(milliseconds: 500), () {
                                  listViewScrollController.animateTo(
                                    listViewScrollController.position.maxScrollExtent,
                                    duration: const Duration(seconds: 1),
                                    curve: Curves.fastOutSlowIn,
                                  );
                                });
                              },
                              maxLines: 5,
                              minLines: 1,
                              controller: messageController,
                              decoration: const InputDecoration(
                                hintText: "Write message...",
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(left: 15, right: 15, top: 0, bottom: 0)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.only(right: 10),
                          height:40,
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
                            shape: const CircleBorder(),
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
