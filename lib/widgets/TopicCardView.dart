import 'package:flutter/material.dart';
import '../backend/models.dart';

class TopicCardView extends StatelessWidget {
  final Topic topic;
  const TopicCardView({Key? key, required this.topic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()  {
        print("test");
      },
      child: Card(
        child: ListTile(
            title: Text(topic.title),
            subtitle: Text(
              topic.contributorId,
            ),
          )
      )
    );
  }
}