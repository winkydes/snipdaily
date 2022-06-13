import 'package:flutter/material.dart';
import 'package:snipdaily/fragments/AddSnippetFragment.dart';
import 'package:snipdaily/fragments/ProfileFragment.dart';
import 'package:snipdaily/fragments/AskFragment.dart';
import 'package:snipdaily/fragments/SnippetListFragment.dart';
import 'package:snipdaily/fragments/CommunityFragment.dart';
import 'package:snipdaily/fragments/SettingsFragment.dart';

class HomeScreen extends StatefulWidget {
  final bool isAdmin;
  const HomeScreen({Key? key, required this.isAdmin}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  var widgetOptions = [
    const SnippetListFragment(),
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
    if (selectedIndex == 4) {
      return AppBar(
        backgroundColor: const Color.fromARGB(255, 174, 123, 241),
        title: Text(widgetTitle.elementAt(selectedIndex)),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsFragment()));
            },
          )
        ],
      );
    }
    else {
      return AppBar(
          backgroundColor: const Color.fromARGB(255, 174, 123, 241),
          title: Text(widgetTitle.elementAt(selectedIndex)),
        );
    }
  }
  
  BottomNavigationBar customBottomNavigationBar() {
    if (widget.isAdmin) {
      return (
        BottomNavigationBar(
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
        )
      );
    }
    else {
      return (
        BottomNavigationBar(
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
        )
      );
    }
  }

  var widgetTitle = ["Home", "Community", "Add Snippet", "Ask", "Profile"];

  @override
  void initState() {
    if (!widget.isAdmin) {
      setState(() {
        widgetOptions = [
          const SnippetListFragment(),
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
        appBar: customAppbar(),
        body: Center(
          child: widgetOptions.elementAt(selectedIndex),
        ),
        bottomNavigationBar: customBottomNavigationBar(),
      ),
    );
  }
}
