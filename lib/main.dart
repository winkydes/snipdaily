import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snipdaily/HomeScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:snipdaily/assets/GlobalTheme.dart';
import 'firebase_options.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'fragments/AddTopicFragment.dart';
import 'fragments/SettingsFragment.dart';
import 'fragments/adminFragments/AdminHomeFragment.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        Provider<GlobalTheme>(
          create: (context) => GlobalTheme(),
        )
      ],
      child: const Login()
      )
  );
}

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData globalLightTheme = Provider.of<GlobalTheme>(context).globalLightTheme;
    final ThemeData globalDarkTheme = Provider.of<GlobalTheme>(context).globalDarkTheme;
    return MaterialApp(
      theme: globalLightTheme,
      darkTheme: globalDarkTheme,
      title: 'SnipDaily',
      initialRoute: '/',
      routes: {
        '/': ((context) => const LoginWidget()),
        '/settings': ((context) => const SettingsFragment()),
        '/adminHome': ((context) => const AdminHomeFragment()),
        '/addTopic': ((context) => const AddTopicFragment()),
      },
    );
  }
}

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {

  bool loginState = false;
  String userId = '';
  String? displayName = '';
  var db = FirebaseFirestore.instance;

  Future<void> setAuthData(Map<String, dynamic> data) async {
    if (FirebaseAuth.instance.currentUser != null) {
      final user = FirebaseAuth.instance.currentUser;
      return db.collection('Users').doc(user?.uid).set(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        initialData: FirebaseAuth.instance.currentUser,
        builder: (context, snapshot) {

          FirebaseAuth.instance.authStateChanges().listen((User? user) {
            if (user == null) {
              loginState = false;
            } else {
              loginState = true;
              userId = user.uid;
              displayName = user.displayName;
            }
          });

          if (loginState == true) {
            final userBody = <String, dynamic> {
              "uid": userId,
              "isLogin": loginState,
              "displayName": displayName,
            };
            setAuthData(userBody);
          }

          if (!snapshot.hasData) {
            return const SignInScreen(
              providerConfigs: [
                EmailProviderConfiguration(),
              ]
            );
          }
          // this email can later be change to any admin email
          else if (snapshot.data?.email == "keithlam0110@gmail.com") {
            return const AdminHomeFragment();
          }
          return const HomeScreen();
        },
      );
  }
}