import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:snipdaily/widgets/BackableAppBar.dart';
import 'package:snipdaily/widgets/SettingsItemWidget.dart';

class SettingsFragment extends StatelessWidget {
  const SettingsFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: BackableAppBar(title: const Text("Settings"), appBar: AppBar(), widgets: [], pageContext: context),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children:const [
            SettingsItemWidget()
          ],
        ),
      ),
    );
  }
}