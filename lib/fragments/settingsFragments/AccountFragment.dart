import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:provider/provider.dart';

import '../../assets/GlobalTheme.dart';
import '../../widgets/BackableAppBar.dart';

class AccountFragment extends StatefulWidget {
  const AccountFragment({Key? key}) : super(key: key);

  @override
  State<AccountFragment> createState() => _AccountFragmentState();
}

class _AccountFragmentState extends State<AccountFragment> {
  @override
  Widget build(BuildContext context) {

    final ThemeData globalLightTheme = Provider.of<GlobalTheme>(context).globalLightTheme;
    final ThemeData globalDarkTheme = Provider.of<GlobalTheme>(context).globalDarkTheme;
    return MaterialApp(
      theme: globalLightTheme,
      darkTheme: globalDarkTheme,
      home: Scaffold(
        appBar: BackableAppBar(title: const Text("Account Settings"), appBar: AppBar(), widgets: [], pageContext: context),
        body: const ProfileScreen(
          providerConfigs:[
            EmailProviderConfiguration(),
          ],
          avatarSize: 100,
        ),
      ),
    );
  }
}