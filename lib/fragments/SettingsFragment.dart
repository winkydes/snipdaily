import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snipdaily/fragments/settingsFragments/AccountFragment.dart';
import 'package:snipdaily/widgets/BackableAppBar.dart';
import 'package:snipdaily/widgets/SettingsItemWidget.dart';

import '../assets/GlobalTheme.dart';

class SettingsFragment extends StatelessWidget {
  const SettingsFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData globalLightTheme = Provider.of<GlobalTheme>(context).globalLightTheme;
    final ThemeData globalDarkTheme = Provider.of<GlobalTheme>(context).globalDarkTheme;
    return MaterialApp(
      theme: globalLightTheme,
      darkTheme: globalDarkTheme,
      home: Scaffold(
        appBar: BackableAppBar(title: const Text("Settings"), appBar: AppBar(), widgets: [], pageContext: context),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            SettingsItemWidget(name: "Account Settings", onTapAction: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const AccountFragment()));},),
            SettingsItemWidget(name: "Light/Dark mode", onTapAction: () {},),
            SettingsItemWidget(name: "Change Preference", onTapAction: () {},),
            SettingsItemWidget(name: "Change Your Password", onTapAction: () {},),
            SettingsItemWidget(name: "Contact us", onTapAction: () {},),
          ],
        ),
      ),
    );
  }
}