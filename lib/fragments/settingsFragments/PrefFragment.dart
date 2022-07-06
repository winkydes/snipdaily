import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../assets/constants.dart';

var db = FirebaseFirestore.instance;

class PrefFragment extends StatefulWidget {
  const PrefFragment({Key? key}) : super(key: key);

  @override
  State<PrefFragment> createState() => _PrefFragmentState();
}

class _PrefFragmentState extends State<PrefFragment> {
  late List<bool?> checkedList = List<bool?>.filled(LANGUAGE.length, false);
  int counter = 0;

  List<Widget> languageCheckList() {
    return LANGUAGE.map((e) => CheckboxListTile(
      title: Text(e),
      value: checkedList[LANGUAGE.indexOf(e)],
      onChanged: (value) {
        print(checkedList);
        print(value);
        setState(() {
          checkedList[LANGUAGE.indexOf(e)] = value;
        });
      }
    )).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Change Language Preference")),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: db.collection('Users').where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid).snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                checkedList = List<bool?>.filled(LANGUAGE.length, false);
              } else {
                if (counter == 0) {
                  for (var item in snapshot.data!.docs.first['languagePrefs']) {
                    checkedList[LANGUAGE.indexOf(item)] = true;
                  }
                  counter++;
                }
              }
              return Column(
                  children: languageCheckList(),
              );
            }
          ),
          ElevatedButton(
            onPressed: () {
              List<int> indexList = [];
              List<String> updatedLanguageList = [];
              int cnt = 0;
              for (var element in checkedList) {
                if (element == true) {
                  indexList.add(checkedList.indexOf(element, cnt));
                }
                cnt++;
              }
              for (var index in indexList) {
                updatedLanguageList.add(LANGUAGE[index]);
              }
              db.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).update({"languagePrefs": updatedLanguageList});
              Navigator.pop(context);
            },
            child: const Text("Save")
          ),
        ]
      ),
    );
  }
}