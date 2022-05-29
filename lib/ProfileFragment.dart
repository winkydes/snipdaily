import 'package:flutter/material.dart';
import 'package:snipdaily/main.dart';

class ProfileFragment extends StatefulWidget {
  const ProfileFragment({Key? key}) : super(key: key);

  @override
  State<ProfileFragment> createState() => _ProfileFragmentState();
}

class _ProfileFragmentState extends State<ProfileFragment> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: ElevatedButton(
            child: const Text('Login'),
              onPressed: () {
                Navigator.pop(context);
              },
          )
        ),
      ],
    );
  }
}