import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snipdaily/HomeScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:snipdaily/assets/GlobalTheme.dart';
import 'package:snipdaily/fragments/exploreFragments/RandomSnippetFragment.dart';
import 'firebase_options.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'fragments/AddTopicFragment.dart';
import 'fragments/SettingsFragment.dart';
import 'fragments/TodaySnipSplashFragment.dart';
import 'fragments/adminFragments/AdminHomeFragment.dart';
import 'fragments/exploreFragments/CategoryFragment.dart';
import 'fragments/exploreFragments/LanguageFragment.dart';
import 'fragments/exploreFragments/SearchFragment.dart';
import 'fragments/settingsFragments/PrefFragment.dart';


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
      debugShowCheckedModeBanner: false,
      theme: globalLightTheme,
      darkTheme: globalDarkTheme,
      title: 'SnipDaily',
      initialRoute: '/',
      routes: {
        '/': ((context) => const LoginWidget()),
        '/settings': ((context) => const SettingsFragment()),
        '/adminHome': ((context) => const AdminHomeFragment()),
        '/addTopic': ((context) => const AddTopicFragment()),
        '/pref': ((context) => const PrefFragment()),
        '/categories': ((context) => const CategoryFragment()),
        '/languages': ((context) => const LanguageFragment()),
        '/rndSnip': ((context) => const RandomSnippetFragment()),
        '/search': ((context) => const SearchFragment())
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
  String userId = '';
  String? displayName = '';
  var db = FirebaseFirestore.instance;
  int day = DateTime.now().day.toInt();
  bool todayFirstLogin = false;
  bool userExists = false;

  Future<void> setAuthData(Map<String, dynamic> data) async {
    if (FirebaseAuth.instance.currentUser != null) {
      final user = FirebaseAuth.instance.currentUser;
      return db.collection('Users').doc(user?.uid).set(data);
    }
  }

  void loadTodayLogined() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.clear();
    // print(prefs.getBool("login$day"));
    setState(() {
      todayFirstLogin = prefs.getBool("login$day") ?? true;
    });
  }

  void userExistenceAction(String uid) async {
    try {
      var doc = await db.collection('Users').doc(uid).get();
      if (!doc.exists) {
        final userBody = <String, dynamic> {
          "uid": uid,
          "isLogin": true,
          "displayName": "No name",
          "languagePrefs": [],
        };
        setAuthData(userBody);
      } else {
        await db.collection('Users').doc(uid).update({"isLogin": true});
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  void initState() {
    loadTodayLogined();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        initialData: FirebaseAuth.instance.currentUser,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const SignInScreen(
              providerConfigs: [
                EmailProviderConfiguration(),
              ]
            );
          }
          userExistenceAction(snapshot.data!.uid);

          // this email can later be change to any admin email
          if (snapshot.data?.email == "keithlam0110@gmail.com") {
            return const AdminHomeFragment();
          }
          if (todayFirstLogin) {
            return const TodaySnipSplashFragment();
          }
          return const HomeScreen();
        },
      );
  }
}