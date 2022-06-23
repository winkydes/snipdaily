import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:snipdaily/backend/models.dart';
import 'package:snipdaily/fragments/SettingsFragment.dart';
import 'package:snipdaily/widgets/RecentContributionSummaryBox.dart';

class ProfileFragment extends StatefulWidget {
  const ProfileFragment({Key? key}) : super(key: key);

  @override
  State<ProfileFragment> createState() => _ProfileFragmentState();
}

class _ProfileFragmentState extends State<ProfileFragment> {
  var db = FirebaseFirestore.instance;
  var currentUser = FirebaseAuth.instance.currentUser!;
  late final Stream<UserPref> userStream = db.collection("Users").where("uid", isEqualTo: currentUser.uid).snapshots().map((item) => UserPref.fromSnapshot(item.docs.first));
  late var userDisplayName = '';
  late var userUid = '';
  final displayNameEditingController = TextEditingController();

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    displayNameEditingController.dispose();
    super.dispose();
  }
  @override
  void initState() {
    userStream.forEach((element) {
      userDisplayName = element.displayName;
      userUid = element.uid;
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final _screen =  MediaQuery.of(context).size;
    return StreamBuilder<UserPref>(
      stream: userStream,
      builder: (context, snapshot) {
        return Scaffold(
          body: ListView(
            children: [
              Container(
                margin: const EdgeInsets.only(top:20),
                alignment: Alignment.topCenter,
                child: ProfilePicture(name: userDisplayName, radius: 60, fontsize: 40)
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(left: 50),
                child: const EditableUserDisplayName()
              ),
              Container(
                margin: const EdgeInsets.only(left: 5, right: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: _screen.width * 0.30,
                      child: Column(
                        children: const [
                          Text("12", style: TextStyle(fontSize: 30)),
                          Text("Contributions Verified", textAlign: TextAlign.center, style: TextStyle(fontSize: 15), maxLines: 2,)
                        ],
                      ),
                    ),
                    SizedBox(
                      width: _screen.width * 0.30,
                      child: Column(
                        children: const [
                          Text("0", style: TextStyle(fontSize: 30)),
                          Text("Answers Provided", textAlign: TextAlign.center, style: TextStyle(fontSize: 15), maxLines: 2,)
                        ],
                      ),
                    ),
                    SizedBox(
                      width: _screen.width * 0.30,
                      child: Column(
                        children: const [
                          Text("0", style: TextStyle(fontSize: 30)),
                          Text("Achievements Unlocked", textAlign: TextAlign.center, style: TextStyle(fontSize: 15,), maxLines: 2,)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, left: 20),
                child: const Text("Recent Contributions", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))
              ),
              RecentContributionSummaryBox(targetUid: userUid,),
              Column(
                children: <Widget>[
                  TextButton(
                    onPressed: () {_signOut();}, 
                    child: const Text("Sign Out"),
                  ),
                  TextButton(
                    onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsFragment()));},
                    child: const Text("Settings")
                  ),
                ],
              ),
            ],
          ),
        );
      }
    );
  }
}