import 'package:cloud_firestore/cloud_firestore.dart';

class Snippet {
  final String id;
  final String code;
  final String title;
  final String description;
  final String language;
  final String formatType;

  Snippet({required this. id, required this.code, required this.title, required this.description, required this.language, required this.formatType});

  factory Snippet.fromFirestore(QuerySnapshot doc) {
    Map data = doc as Map;
    
    return Snippet(
      id: data['id'] ?? '',
      code: data['code'] ?? '',
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      language: data['language'] ?? '',
      formatType: data['formatType'] ?? '',
    );
  }
}