import 'package:flutter/material.dart';
import 'package:snipdaily/fragments/AddSnippetFragment.dart';
import 'package:snipdaily/fragments/ProfileFragment.dart';
import 'package:snipdaily/fragments/BadgesFragment.dart';
import 'package:snipdaily/fragments/CommunityFragment.dart';
import 'fragments/exploreFragments/ExploreFragment.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  var widgetOptions = [
    const ExploreFragment(),
    const CommunityFragment(),
    const AddSnippetFragment(),
    const BadgesFragment(),
    const ProfileFragment(),
  ];

  var widgetTitle = ["Home", "Community", "Add Snippet", "Ask", "Profile"];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  BottomNavigationBar customBottomNavigationBar() {
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
              label: 'Contribute'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.emoji_events),
              label: 'Badges'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          ),
        ],
        currentIndex: selectedIndex,
        onTap: onItemTapped,
      ));
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(widgetTitle.elementAt(selectedIndex)),
        ),
        body: Center(
          child: widgetOptions.elementAt(selectedIndex),
        ),
        bottomNavigationBar: customBottomNavigationBar(),
    );
  }
}
