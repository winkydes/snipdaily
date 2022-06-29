import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../backend/models.dart';

class MessageBox extends StatelessWidget {
  final Message message;
  const MessageBox({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (message.userId == FirebaseAuth.instance.currentUser!.uid) {
      return BubbleSpecialThree(
        text: message.content,
        color: Colors.lightBlue,
      );
    } else {
      return BubbleSpecialThree(
        text: message.content,
        color: Colors.grey,
        isSender: false,
      );
    }
      
  }
}