import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../widgets/InputTextField.dart';

class ChangePasswordVerifyFragment extends StatefulWidget {
  const ChangePasswordVerifyFragment({Key? key}) : super(key: key);

  @override
  State<ChangePasswordVerifyFragment> createState() => _ChangePasswordVerifyFragmentState();
}

class _ChangePasswordVerifyFragmentState extends State<ChangePasswordVerifyFragment> {
  var passwordController = TextEditingController();

  void checkPassword() async {
    if (passwordController.text == '') {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: Text("Passowrd is missing, please try again."),
          );
        },
      );
      return;
    } else {
      try {
        await FirebaseAuth.instance.currentUser?.reauthenticateWithCredential(
          EmailAuthProvider.credential(
            email: FirebaseAuth.instance.currentUser!.email!,
            password: passwordController.text,
          )
        );
        if (mounted) {
          Navigator.pushNamed(context, "/changePassword");
        }
      } on FirebaseAuthException {
        showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: Text("The password you typed is incorrect. Please try again."),
            );
          }
        );
      }
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
            child: Text("Before proceeding, please type in your original password."),
          ),
          InputTextField(
            maxLines: 1,
            hintText: 'Old Password',
            getTextController: passwordController,
          ),
          TextButton(onPressed: () {checkPassword();}, child: const Text("Verify"))
        ],
      ),
    );
  }
}