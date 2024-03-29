import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:snipdaily/assets/constants.dart';
import 'package:snipdaily/backend/models.dart';
import 'package:snipdaily/widgets/RecentContributionSummaryBox.dart';

class OtherProfileFragment extends StatefulWidget {
  final String authorId;
  const OtherProfileFragment({Key? key, required this.authorId}) : super(key: key);

  @override
  State<OtherProfileFragment> createState() => _OtherProfileFragmentState();
}

class _OtherProfileFragmentState extends State<OtherProfileFragment> {
  var db = FirebaseFirestore.instance;
  var currentUser = FirebaseAuth.instance.currentUser!;
  int likeCount = 0;
  late final Stream<UserPref> userStream = db.collection("Users").where("uid", isEqualTo: widget.authorId).snapshots().map((item) => UserPref.fromSnapshot(item.docs.first));
  late final snipData = db.collection("snippets").where("authorId", isEqualTo: widget.authorId).where("verified", isEqualTo: VERIFIED);
  late final msgData = db.collection("topics").where("contributorId", isEqualTo: FirebaseAuth.instance.currentUser!.uid);
  late var userDisplayName = '';
  late var userUid = '';

  @override
  void initState() {
    userStream.forEach((element) {
      userDisplayName = element.displayName;
      userUid = element.uid;
    });
    snipData.get().then((value) => value.docs.map((item) => Snippet.fromSnapshot(item)).forEach((element) { 
      setState(() {
        likeCount = likeCount + element.liked.length;
      });
    }));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final _screen =  MediaQuery.of(context).size;
    return StreamBuilder<UserPref>(
      stream: userStream,
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(title: Text("$userDisplayName's Profile"),),
          body: ListView(
            children: [
              Container(
                margin: const EdgeInsets.only(top:20),
                alignment: Alignment.topCenter,
                child: ProfilePicture(name: userDisplayName, radius: 60, fontsize: 40)
              ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                child: Text(userDisplayName, style: const TextStyle(fontSize: 25),),
              ),
              Container(
                margin: const EdgeInsets.only(left: 5, right: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FutureBuilder<int>(
                      future: snipData.get().then((value) => value.size),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting: return const Text('Loading....');
                          default:
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              return SizedBox(
                              width: _screen.width * 0.30,
                              child: Column(
                                children: [
                                  Text(snapshot.data.toString(), style: const TextStyle(fontSize: 30)),
                                  const Text("Contributions Verified", textAlign: TextAlign.center, style: TextStyle(fontSize: 15), maxLines: 2,)
                                ],
                              ),
                            );
                            }
                          }
                        }
                    ),
                    SizedBox(
                      width: _screen.width * 0.30,
                      child: FutureBuilder<int>(
                        future: msgData.get().then((value) => value.size),
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting: return const Center(child: Text('Loading....'));
                            default:
                              if (snapshot.hasError) {
                                return Center(child: Text('Error: ${snapshot.error}'));
                              } else {
                                return Column(
                                  children: [
                                    Text(snapshot.data.toString(), style: const TextStyle(fontSize: 30)),
                                    const Text("Threads created", textAlign: TextAlign.center, style: TextStyle(fontSize: 15), maxLines: 2,)
                                  ],
                                );
                              }
                          }
                        }
                      ),
                    ),
                    SizedBox(
                      width: _screen.width * 0.30,
                      child: 
                        Column(
                          children: [
                            Text(likeCount.toString(), style: const TextStyle(fontSize: 30)),
                            const Text("Likes gained", textAlign: TextAlign.center, style: TextStyle(fontSize: 15), maxLines: 2,)
                          ],
                        )
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, left: 20),
                child: const Text("Recent Contributions", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))
              ),
              RecentContributionSummaryBox(targetUid: widget.authorId,),
            ],
          ),
        );
      }
    );
  }
}