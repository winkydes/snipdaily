import 'package:cloud_firestore/cloud_firestore.dart';

class Snippet {
  final String id;
  final String code;
  final String title;
  final String description;
  final String language;
  final String formatType;
  final String type;
  final String author;

  Snippet({required this.id, required this.code, required this.title, required this.description, required this.language, required this.formatType, required this.type, required this.author});

  factory Snippet.fromSnapshot(DocumentSnapshot snapshot) {
    
    return Snippet(
      id: snapshot.id,
      code: snapshot['code'] ?? '',
      title: snapshot['title'] ?? '',
      description: snapshot['description'] ?? '',
      language: snapshot['language'] ?? '',
      formatType: snapshot['formatType'] ?? '',
      type: snapshot['type'] ?? '',
      author: snapshot['author'] ?? '',
    );
  }
}