import 'package:flutter/material.dart';
import 'package:snipdaily/ProfileFragment.dart';
import 'package:snipdaily/AskFragment.dart';
import 'package:snipdaily/HomeFragment.dart';

class SnipDaily extends StatefulWidget {
  const SnipDaily({Key? key}) : super(key: key);

  @override
  State<SnipDaily> createState() => _SnipDailyState();
}

class _SnipDailyState extends State<SnipDaily> {

  int selectedIndex = 0;

  final widgetOptions = [
    const HomeFragment(),
    const AskFragment(),
    const ProfileFragment(),
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  final widgetTitle = ["Home", "Ask", "Profile"];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purpleAccent,
          title: Text(widgetTitle.elementAt(selectedIndex)),
        ),
        body: Center(
          child: widgetOptions.elementAt(selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.question_mark),
              label: 'Ask',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_box),
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