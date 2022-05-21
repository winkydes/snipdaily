import 'package:flutter/material.dart';

void main() {
  runApp(const SnipDaily());
}

class SnipDaily extends StatelessWidget {
  const SnipDaily({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purpleAccent,
          title: const Text('Demo'),
        ),
        body: Center(
          child: Container(
            color: Colors.blue,
            height: 100,
            width: 100,
            child: const Text('Home'),
            ),
          
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
        ),
      ),
    );
  }
}
