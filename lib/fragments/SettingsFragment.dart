import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
          children:const [
            SettingsItemWidget(name: "Light/Dark mode"),
            SettingsItemWidget(name: "Change Preference"),
            SettingsItemWidget(name: "Change Your Password"),
            SettingsItemWidget(name: "Contact us"),
          ],
        ),
      ),
    );
  }
}