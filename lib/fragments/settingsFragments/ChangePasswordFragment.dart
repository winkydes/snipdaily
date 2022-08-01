import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChangePasswordFragment extends StatefulWidget {
  const ChangePasswordFragment({Key? key}) : super(key: key);

  @override
  State<ChangePasswordFragment> createState() => _ChangePasswordFragmentState();
}

class _ChangePasswordFragmentState extends State<ChangePasswordFragment> {
  var passwordController = TextEditingController();

  void updatePassword() async {
    try {
      await FirebaseAuth.instance.currentUser?.updatePassword(passwordController.text);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: const Text("Password updated!"),
            actions: [
              TextButton(onPressed: () {Navigator.pushNamedAndRemoveUntil(context,'/', (_) => false);}, child: const Text("OK")),
            ],
          );
        }
      );
    } on FirebaseAuthException {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: Text("The password you typed is not strong enough or is the same as the old password. Please make sure your password has at least 6 characters."),
          );
        }
      );
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Change your password")),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Please type in your new password"),
          ),
          TextField(
            controller: passwordController,
          ),
          TextButton(onPressed: () {updatePassword();}, child: const Text("Verify"))

        ],
      ),
    );
  }
}