import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../backend/models.dart';
import '../main.dart';
import '../widgets/LanguageLabel.dart';
import '../widgets/TypeLabel.dart';

class TodaySnipSplashFragment extends StatefulWidget {
  const TodaySnipSplashFragment({Key? key}) : super(key: key);

  @override
  State<TodaySnipSplashFragment> createState() => _TodaySnipSplashFragmentState();
}

class _TodaySnipSplashFragmentState extends State<TodaySnipSplashFragment> {
  int day = DateTime.now().day.toInt();

  void updatePref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear(); //clear previous preferences
    prefs.setBool("login$day", false);
  }

  double customFontSize = 15;

  resize(bool larger) {
    if (larger && customFontSize < 30) {
      setState(() {
        customFontSize = customFontSize + 5;
      });
    }
    else if (!larger && customFontSize > 10) {
      setState(() {
        customFontSize = customFontSize - 5;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Iterable<Snippet>>(
      stream: FirebaseFirestore.instance
        .collection('snippets')
        .snapshots()
        .map((item) => item.docs.map((doc) => Snippet.fromSnapshot(doc))),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        List<Snippet> randomSnippetList = snapshot.data!.toList();
        randomSnippetList.shuffle();
        Snippet randomSnip = randomSnippetList.first;
        return Scaffold(
          appBar: AppBar(title: const Text("Today's Snippet")),
          body: ListView(
            padding: const EdgeInsets.only(
                left: 20, right: 20, top: 20, bottom: 20),
            children: [
              Text(
                randomSnip.title,
                style: Theme.of(context).textTheme.headline5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    LanguageLabel(language: randomSnip.language),
                    TypeLabel(type: randomSnip.type),
                  ],
                ),
              ]),
              Card(
                child: Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 20),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Text(randomSnip.code,
                      style: TextStyle(
                        fontSize: customFontSize,
                        fontFamily: 'Consolas',
                      ))),
              ),
              Card(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    randomSnip.description,
                    style: const TextStyle(fontSize: 18.0, height: 1.5),
                  )),
              ),
              ElevatedButton(
                onPressed: () {
                  updatePref();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginWidget()));
                },
                child: const Text("Continue")),
            ],
          ),
        );
      }
    );
  }
}