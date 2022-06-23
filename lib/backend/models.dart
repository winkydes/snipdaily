import 'package:cloud_firestore/cloud_firestore.dart';

class Snippet {
  final String id;
  final String code;
  final String title;
  final String description;
  final String language;
  final String formatType;
  final String type;
  final String authorId;
  final String verified;

  Snippet({required this.id, required this.code, required this.title, required this.description, required this.language, required this.formatType, required this.type, required this.authorId, required this.verified});

  factory Snippet.fromSnapshot(DocumentSnapshot snapshot) {
    
    return Snippet(
      id: snapshot.id,
      code: snapshot.data().toString().contains('code') ? snapshot.get('code') : '',
      title: snapshot.data().toString().contains('title') ? snapshot.get('title') : '',
      description: snapshot.data().toString().contains('description') ? snapshot.get('description') : '',
      language: snapshot.data().toString().contains('language') ? snapshot.get('language') : '',
      formatType: snapshot.data().toString().contains('formatType') ? snapshot.get('formatType') : '',
      type: snapshot.data().toString().contains('type') ? snapshot.get('type') : '',
      authorId: snapshot.data().toString().contains('authorId') ? snapshot.get('authorId') : '',
      verified: snapshot.data().toString().contains('verified') ? snapshot.get('verified') : '',
    );
  }
}

class UserPref {
  final String uid;
  final String displayName;
  final bool isLogin;

  UserPref({required this.uid, required this.displayName, required this.isLogin});

  factory UserPref.fromSnapshot(DocumentSnapshot snapshot) {
    return UserPref(
      uid: snapshot.data().toString().contains('uid') ? snapshot.get('uid') : '',
      displayName: snapshot.data().toString().contains('displayName') ? snapshot.get('displayName') : '',
      isLogin: snapshot.data().toString().contains('isLogin') ? snapshot.get('isLogin') : '',
    );
  }
}