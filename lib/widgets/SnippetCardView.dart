import 'package:flutter/material.dart';

class SnippetCardView extends StatelessWidget {

  final String title;
  final String language;
  final String author;

  const SnippetCardView({Key? key, required this.title, required this.language, required this.author}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text(title),
            subtitle: Text(
              "$language, by $author",
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
          ),
        ],
      ),
    );
  }
}
