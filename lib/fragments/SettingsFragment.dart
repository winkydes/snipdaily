import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:snipdaily/widgets/SettingsItemWidget.dart';

import '../main.dart';

class SettingsFragment extends StatefulWidget {
  const SettingsFragment({Key? key}) : super(key: key);

  @override
  State<SettingsFragment> createState() => _SettingsFragmentState();
}

class _SettingsFragmentState extends State<SettingsFragment> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings"),),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          SettingsItemWidget(name: "Light/Dark mode", onTapAction: () {
            Login.themeNotifier.value =
                  Login.themeNotifier.value == ThemeMode.light
                      ? ThemeMode.dark
                      : ThemeMode.light;
          },),
          SettingsItemWidget(name: "Change Language Preference", onTapAction: () {
            Navigator.pushNamed(context, "/pref");
          },),
          SettingsItemWidget(name: "Change Your Password", onTapAction: () {
            Navigator.pushNamed(context, "/changePasswordVerify");
          },),
          SettingsItemWidget(name: "Report a problem", onTapAction: () {
            Navigator.pushNamed(context, "/report");
          },),
          SettingsItemWidget(name: "Delete Account", onTapAction: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: const Text("Are you sure you want to delete your account? This action is not reversible.", textAlign: TextAlign.center, style: TextStyle(fontSize: 20),),
                  actions: [
                    TextButton(
                      onPressed: () async {
                        await FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).delete();
                        await FirebaseAuth.instance.currentUser?.delete();
                        if (!mounted) return;
                        Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
                      },
                      child: const Text("OK")),
                    TextButton(onPressed: () {Navigator.pop(context);}, child: const Text("Cancel")),
                  ],
                );
              },
            );
          })
        ],
      ),
    );
  }
}