import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:snipdaily/fragments/SettingsFragment.dart';

class ProfileFragment extends StatefulWidget {
  const ProfileFragment({Key? key}) : super(key: key);

  @override
  State<ProfileFragment> createState() => _ProfileFragmentState();
}

class _ProfileFragmentState extends State<ProfileFragment> {

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children:  [
        TextButton(
          onPressed: () {_signOut();}, 
          child: const Text("Sign Out"),
        ),
        TextButton(
          onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsFragment()));},
          child: const Text("Settings")
        )
      ],
    );
  }
}