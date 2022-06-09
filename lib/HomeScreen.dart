import 'package:flutter/material.dart';
import 'package:snipdaily/fragments/AddSnippetFragment.dart';
import 'package:snipdaily/fragments/ProfileFragment.dart';
import 'package:snipdaily/fragments/AskFragment.dart';
import 'package:snipdaily/fragments/ExploreFragment.dart';
import 'package:snipdaily/fragments/CommunityFragment.dart';

class SnipDaily extends StatefulWidget {
  const SnipDaily({Key? key}) : super(key: key);

  @override
  State<SnipDaily> createState() => _SnipDailyState();
}

class _SnipDailyState extends State<SnipDaily> {

  int selectedIndex = 0;

  final widgetOptions = [
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

  final widgetTitle = ["Home","Community","Add Snippet", "Ask", "Profile"];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 174, 123, 241),
        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline5: TextStyle(fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 20.0),
          bodyText1: TextStyle(fontSize: 18.0, fontFamily: 'Hind'),
        ),
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 174, 123, 241),
          title: Text(widgetTitle.elementAt(selectedIndex)),
        ),
        body: Center(
          child: widgetOptions.elementAt(selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
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
              icon: Icon(Icons.question_mark),
              label:'Ask'
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Account',
            ),
            
          ],
          currentIndex: selectedIndex,
          onTap: onItemTapped,
        ),
      ),
    );
  }
}