import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snipdaily/HomeScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:snipdaily/assets/GlobalTheme.dart';
import 'firebase_options.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';


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
    return const MaterialApp(
      title: 'SnipDaily',
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: LoginWidget(),
      ),
    );
  }
}

class LoginWidget extends StatelessWidget {
  const LoginWidget({Key? key}) : super(key: key);

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
          // this email can later be change to any admin email
          else if (snapshot.data?.email == "keithlam0110@gmail.com") {
            return const HomeScreen(isAdmin: true);
          }
          return const HomeScreen(isAdmin: false);
        },
      );
  }
}