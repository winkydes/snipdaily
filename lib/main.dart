import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:snipdaily/MainClass.dart';

void main() {
  runApp( const Login());
}

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SnipDaily',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('SnipDaily'),
          backgroundColor: const Color.fromRGBO(80, 128, 250, 100),),
        body: const LoginWidget(),
      ),
    );
  }
}

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {

  static const _primaryTextColor = Color.fromRGBO(92, 77, 250, 100);

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(231, 224, 236, 255),
      body: ListView(
        children: <Widget>[
          Container(
            color: Colors.white,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.all(10),
            child: const Text(
              'SnipDaily',
              style: TextStyle(
                color: _primaryTextColor,
                fontWeight: FontWeight.w500,
                fontSize: 50,
              ),
            )
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Welcome back, please sign in to continue!',
              style: TextStyle(
                color: _primaryTextColor,
                fontWeight: FontWeight.w500,
                fontSize: 17,
              ),
            )
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: nameController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'User Name',
              ),
            )
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
              ),
            )
          ),
          Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child: const Text('Login'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SnipDaily())
                    );
                  },
                )
            ),
        ],
      )
    );
  }
}