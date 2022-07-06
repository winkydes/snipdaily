import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../backend/models.dart';
import '../fragments/OtherProfileFragment.dart';

class MessageBox extends StatelessWidget {
  final Message message;
  final bool isFirstMsgOfDay;
  const MessageBox({Key? key, required this.message, required this.isFirstMsgOfDay}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formattedTime = "${message.time.hour.toString().padLeft(2, '0')}:${message.time.minute.toString().padLeft(2, '0')}";
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
        .collection('Users')
        .where("uid", isEqualTo: message.userId)
        .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError || snapshot.data == null) {
          return const Center(child: Text("error"),);
        }
        return Column(
          children: [
            (!isFirstMsgOfDay ? const SizedBox.shrink() : Align(alignment: Alignment.center ,child: Text("${message.time.year.toString()}-${message.time.month.toString().padLeft(2,'0')}-${message.time.day.toString().padLeft(2,'0')}"),)),
            Align(
              alignment: (message.userId == FirebaseAuth.instance.currentUser!.uid? Alignment.centerRight: Alignment.centerLeft),
              child: Container(
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: (message.userId == FirebaseAuth.instance.currentUser!.uid? Colors.blue[200] : Colors.grey[200]),
                ),
                padding: const EdgeInsets.only(left: 8, right: 8, top:8, bottom:4),
                child: Column(
                  crossAxisAlignment: (message.userId == FirebaseAuth.instance.currentUser!.uid? CrossAxisAlignment.end : CrossAxisAlignment.start),
                  children: [
                    (message.userId == FirebaseAuth.instance.currentUser!.uid?
                      const SizedBox.shrink()
                       : 
                      GestureDetector(
                        onTap: () {
                          if (snapshot.data!.docs.isNotEmpty){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => OtherProfileFragment(authorId: message.userId,)));
                          }
                        },
                        child: Text(snapshot.data!.docs.isEmpty? 'Deleted User' : snapshot.data!.docs.first['displayName'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black),)
                        )
                    ),
                    Wrap(
                      children: [
                        Text(message.content, style: const TextStyle(fontSize: 20, color: Colors.black),),
                        Container(padding: const EdgeInsets.only(top: 10, left: 10),child: Text(formattedTime, style: const TextStyle(color: Colors.grey)))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }
    ); 
  }
}