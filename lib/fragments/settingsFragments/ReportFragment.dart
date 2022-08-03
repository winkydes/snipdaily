import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

var db = FirebaseFirestore.instance;

class ReportFragment extends StatefulWidget {
  const ReportFragment({Key? key}) : super(key: key);

  @override
  State<ReportFragment> createState() => _ReportFragmentState();
}

class _ReportFragmentState extends State<ReportFragment> {
  var reportController = TextEditingController();

  sendReport() {
    if (reportController.text.isNotEmpty) {
      final report = <String, dynamic> {
        "userId": FirebaseAuth.instance.currentUser!.uid,
        "reportContent": reportController.text,
      };
      db.collection("report").add(report);
      Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: const Text("Some fields are missing, please try again."),
            actions: [
              TextButton(onPressed: () {Navigator.pop(context);}, child: const Text("OK")),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Report a Problem")),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Please let know what is wrong in the textbox below! We will handle your issue soon."),
          ),
          TextField(
            controller: reportController,
            maxLines: 5,
          ),
          TextButton(onPressed: () {sendReport();}, child: const Text("Send"))
        ],
      ),
    );
  }
}