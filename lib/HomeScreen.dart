import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snipdaily/fragments/AddSnippetFragment.dart';
import 'package:snipdaily/fragments/ProfileFragment.dart';
import 'package:snipdaily/fragments/AskFragment.dart';
import 'package:snipdaily/fragments/SnippetListFragment.dart';
import 'package:snipdaily/fragments/CommunityFragment.dart';
import 'package:snipdaily/fragments/SettingsFragment.dart';

import 'assets/GlobalTheme.dart';
import 'fragments/ExploreFragment.dart';

class HomeScreen extends StatefulWidget {
  final bool isAdmin;
  const HomeScreen({Key? key, required this.isAdmin}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  var widgetOptions = [
    const ExploreFragment(),
    const CommunityFragment(),
    const AddSnippetFragment(),
    const AskFragment(),
    const ProfileFragment(),
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  AppBar customAppbar() {
    if ((widget.isAdmin && selectedIndex == 4) ||
        (!widget.isAdmin && selectedIndex == 3)) {
      return AppBar(
        title: Text(widgetTitle.elementAt(selectedIndex)),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SettingsFragment()));
            },
          )
        ],
      );
    } else {
      return AppBar(
        title: Text(widgetTitle.elementAt(selectedIndex)),
      );
    }
  }

  BottomNavigationBar customBottomNavigationBar() {
    if (widget.isAdmin) {
      return (BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.groups),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Contribute',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.question_mark), label: 'Ask'),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          ),
        ],
        currentIndex: selectedIndex,
        onTap: onItemTapped,
      ));
    } else {
      return (BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.groups),
            label: 'Community',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.question_mark), label: 'Ask'),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          ),
        ],
        currentIndex: selectedIndex,
        onTap: onItemTapped,
      ));
    }
  }

  var widgetTitle = ["Home", "Community", "Add Snippet", "Ask", "Profile"];

  @override
  void initState() {
    if (!widget.isAdmin) {
      setState(() {
        widgetOptions = [
          const ExploreFragment(),
          const CommunityFragment(),
          const AskFragment(),
          const ProfileFragment(),
        ];
        widgetTitle = ["Home", "Community", "Ask", "Profile"];
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData globalLightTheme = Provider.of<GlobalTheme>(context).globalLightTheme;
    final ThemeData globalDarkTheme = Provider.of<GlobalTheme>(context).globalDarkTheme;
    return MaterialApp(
      theme: globalLightTheme,
      darkTheme: globalDarkTheme,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: customAppbar(),
        body: Center(
          child: widgetOptions.elementAt(selectedIndex),
        ),
        bottomNavigationBar: customBottomNavigationBar(),
      ),
    );
  }
}
