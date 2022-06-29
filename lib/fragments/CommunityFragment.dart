import 'package:flutter/material.dart';

class CommunityFragment extends StatefulWidget {
  const CommunityFragment({Key? key}) : super(key: key);

  @override
  State<CommunityFragment> createState() => _CommunityFragmentState();
}

class _CommunityFragmentState extends State<CommunityFragment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(child: Text('Press the button below!')),
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