import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snipdaily/widgets/BackableAppBar.dart';
import 'package:snipdaily/widgets/SettingsItemWidget.dart';

import '../assets/GlobalTheme.dart';

class SettingsFragment extends StatelessWidget {
  const SettingsFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Settings"),),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            SettingsItemWidget(name: "Account Settings", onTapAction: () {},),
            SettingsItemWidget(name: "Light/Dark mode", onTapAction: () {},),
            SettingsItemWidget(name: "Change Preference", onTapAction: () {},),
            SettingsItemWidget(name: "Change Your Password", onTapAction: () {},),
            SettingsItemWidget(name: "Contact us", onTapAction: () {},),
          ],
        ),
    );
  }
}