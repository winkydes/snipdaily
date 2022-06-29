import 'package:cloud_firestore/cloud_firestore.dart';
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
  late final _messageStream = db
      .collection('topics')
      .doc(widget.topic.id)
      .collection('message')
      .snapshots()
      .map((item) => item.docs.map((doc) => Message.fromSnapshot(doc)));

  late final List<Widget> messageList = [];

  @override
  void initState() {
    _messageStream.forEach((element) => {
          element.forEach((message) => messageList.add(MessageBox(message: message)))
        });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.topic.title)),
      body: StreamBuilder<Iterable<Message>>(
          stream: _messageStream,
          builder: (context, snapshot) {
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
            if (messageList.isEmpty) {
              return const Center(
                child: Text(
                  'No message',
                  textAlign: TextAlign.center,
                ),
              );
            }
            return ListView(
              children: messageList,
            );
          }),
    );
  }
}
