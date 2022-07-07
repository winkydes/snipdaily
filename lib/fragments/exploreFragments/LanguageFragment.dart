import 'package:flutter/material.dart';
import 'package:snipdaily/fragments/exploreFragments/languageSnipFilterFragment.dart';
import 'package:snipdaily/widgets/SettingsItemWidget.dart';

import '../../assets/constants.dart';
import '../../widgets/LanguageLabel.dart';

class LanguageFragment extends StatelessWidget {
  const LanguageFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Programming Languages")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Align(
          alignment: Alignment.topCenter,
          child: ListView(
            children: (LANGUAGE
                .map(
                  (lang) => SettingsItemWidget(
                    onTapAction: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) =>
                                  LanguageSnipFilterFragment(language: lang)));
                    },
                    name: lang,
                  ),
                )
                .toList()),
          ),
        ),
      ),
    );
  }
}
