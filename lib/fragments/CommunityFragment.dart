import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../backend/models.dart';
import '../widgets/topicCardView.dart';

class CommunityFragment extends StatefulWidget {
  const CommunityFragment({Key? key}) : super(key: key);

  @override
  State<CommunityFragment> createState() => _CommunityFragmentState();
}

class _CommunityFragmentState extends State<CommunityFragment> {

  late final Stream<Iterable<Topic>> _topicStream = FirebaseFirestore
    .instance
    .collection('topics')
    .snapshots()
    .map((item) => item.docs.map((doc) => Topic.fromSnapshot(doc)));

  late final List<Widget> topicList = [];

  @override
  void initState() {
    _topicStream.forEach((element) => {
      element.forEach((topic) => topicList.add(TopicCardView(
        topic: topic,
      )))
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<Iterable<Topic>>(
        stream: _topicStream,
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
          if (topicList.isEmpty) {
            return const Center(
              child: Text(
                'There are no topics yet.'
              ),
            );
          }
          return ListView(
            padding: const EdgeInsets.all(10),
            children: topicList,
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/addTopic');
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        child: const Icon(Icons.add),
      ),
    );
  }
}