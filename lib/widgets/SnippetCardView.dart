import 'package:flutter/material.dart';

import '../fragments/SnippetDetailFragment.dart';

class SnippetCardView extends StatelessWidget {

  final String title;
  final String language;
  final String snipId;

  const SnippetCardView({Key? key, required this.title, required this.language, required this.snipId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(context, MaterialPageRoute(builder: (context) => SnippetDetailFragment(id: snipId)))
      },
      child: Card(
        child: Column(
          children: [
            ListTile(
              title: Text(title),
              subtitle: Text(
                language,
                style: TextStyle(color: Colors.black.withOpacity(0.6)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
