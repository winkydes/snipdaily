import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snipdaily/fragments/ProfileFragment.dart';
import 'package:snipdaily/assets/GlobalTheme.dart';
import 'package:snipdaily/fragments/adminFragments/AdminVerifySnippetFragment.dart';

class AdminHomeFragment extends StatefulWidget {
  const AdminHomeFragment({Key? key}) : super(key: key);

  @override
  State<AdminHomeFragment> createState() => _AdminHomeFragmentState();
}

class _AdminHomeFragmentState extends State<AdminHomeFragment> {
  int selectedIndex = 0;

  var widgetOptions = [
    const AdminVerifySnippetFragment(),
    const ProfileFragment()
  ];

  var widgetTitle = ["Verifify Snippet"];

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
            icon: Icon(Icons.incomplete_circle),
            label: 'Verify',
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
      appBar: AppBar(),
      body: Center(
        child: widgetOptions.elementAt(selectedIndex),
      ),
      bottomNavigationBar: customBottomNavigationBar(),
    );
  }
}
