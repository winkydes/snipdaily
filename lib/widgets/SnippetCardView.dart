import 'package:flutter/material.dart';
import '../backend/models.dart';
import '../fragments/SnippetDetailFragment.dart';

class SnippetCardView extends StatelessWidget {

  final Snippet cardSnippet;

  const SnippetCardView({Key? key, required this.cardSnippet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(context, MaterialPageRoute(builder: (context) => SnippetDetailFragment(snip: cardSnippet)))
      },
      child: Card(
        child: Column(
          children: [
            ListTile(
              title: Text(cardSnippet.title),
              subtitle: Text(
                "${cardSnippet.liked.length} 🔥  ${cardSnippet.language}",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
