import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../backend/models.dart';
import '../fragments/ChatroomFragment.dart';

class TopicCardView extends StatelessWidget {
  final Topic topic;
  const TopicCardView({Key? key, required this.topic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()  {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ChatroomFragment(topic: topic)));
      },
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
        .collection('Users')
        .where("uid", isEqualTo: topic.contributorId)
        .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
          } else {
            return Card(
              child: ListTile(
                  title: Text(topic.title),
                  subtitle: Text(
                    snapshot.data!.docs.first['displayName'],
                  ),
                )
            );
          }
        }
      )
    );
  }
}