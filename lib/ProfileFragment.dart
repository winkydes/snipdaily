import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:snipdaily/main.dart';

class ProfileFragment extends StatefulWidget {
  const ProfileFragment({Key? key}) : super(key: key);

  @override
  State<ProfileFragment> createState() => _ProfileFragmentState();
}

class _ProfileFragmentState extends State<ProfileFragment> {
  @override
  Widget build(BuildContext context) {
    return const ProfileScreen(
      providerConfigs:[
        EmailProviderConfiguration(),
      ],
      avatarSize: 24,
    );
  }
}