import 'package:cloud_firestore/cloud_firestore.dart';

class Snippet {
  final String id;
  final String code;
  final String title;
  final String description;
  final String language;
  final String type;
  final String authorId;
  final String verified;
  final DateTime date;
  final List<dynamic> liked;

  Snippet({required this.id, required this.code, required this.title, required this.description, required this.language, required this.type, required this.authorId, required this.verified, required this.date, required this.liked});

  factory Snippet.fromSnapshot(DocumentSnapshot snapshot) {
    
    return Snippet(
      id: snapshot.id,
      code: snapshot.data().toString().contains('code') ? snapshot.get('code') : '',
      title: snapshot.data().toString().contains('title') ? snapshot.get('title') : '',
      description: snapshot.data().toString().contains('description') ? snapshot.get('description') : '',
      language: snapshot.data().toString().contains('language') ? snapshot.get('language') : '',
      type: snapshot.data().toString().contains('type') ? snapshot.get('type') : '',
      authorId: snapshot.data().toString().contains('authorId') ? snapshot.get('authorId') : '',
      verified: snapshot.data().toString().contains('verified') ? snapshot.get('verified') : '',
      date: snapshot.data().toString().contains('date') ? snapshot.get('date').toDate() : DateTime.parse('0000-00-00 00:00:00Z'),
      liked: snapshot.data().toString().contains('liked') ? snapshot.get('liked') : [],
    );
  }
}

class UserPref {
  final String uid;
  final String displayName;
  final bool isLogin;
  final List<dynamic> languagePrefs;

  UserPref({required this.uid, required this.displayName, required this.isLogin, required this.languagePrefs});

  factory UserPref.fromSnapshot(DocumentSnapshot snapshot) {
    return UserPref(
      uid: snapshot.data().toString().contains('uid') ? snapshot.get('uid') : '',
      displayName: snapshot.data().toString().contains('displayName') ? snapshot.get('displayName') : '',
      isLogin: snapshot.data().toString().contains('isLogin') ? snapshot.get('isLogin') : '',
      languagePrefs: snapshot.data().toString().contains('languagePrefs') ? snapshot.get('languagePrefs') : [],
    );
  }
}

class Topic {
  final String id;
  final String title;
  final String contributorId;

  Topic({required this.id, required this.title, required this.contributorId});

  factory Topic.fromSnapshot(DocumentSnapshot snapshot) {
    return Topic(
      id: snapshot.id,
      title: snapshot.data().toString().contains('title') ? snapshot.get('title') : '',
      contributorId: snapshot.data().toString().contains('contributorId') ? snapshot.get('contributorId') : '',
    );
  }
}

class Message {
  final String userId;
  final String content;
  final String topicId;
  final DateTime time;

  Message({required this.userId, required this.content, required this.topicId, required this.time});

  factory Message.fromSnapshot(DocumentSnapshot snapshot) {
    return Message(
      userId: snapshot.data().toString().contains('userId') ? snapshot.get('userId') : '',
      content: snapshot.data().toString().contains('content') ? snapshot.get('content') : '',
      topicId: snapshot.data().toString().contains('topicId') ? snapshot.get('topicId') : '',
      time: snapshot.data().toString().contains('time') ? snapshot.get('time').toDate() : DateTime.parse('0000-00-00 00:00:00Z'),
    );
  }
}

class Report {
  final String userId;
  final String reportContent;

  Report({required this.userId, required this.reportContent});

  factory Report.fromSnapshot(DocumentSnapshot snapshot) {
    return Report(
      userId: snapshot.data().toString().contains('userId') ? snapshot.get('userId') : '',
      reportContent: snapshot.data().toString().contains('reportContent') ? snapshot.get('reportContent') : '',
    );
  }
}