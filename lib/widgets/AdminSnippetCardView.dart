import 'package:flutter/material.dart';
import '../backend/models.dart';
import '../fragments/adminFragments/AdminSnippetDetailFragment.dart';

// Later can add more details to this card for easier manipulation
class AdminSnippetCardView extends StatelessWidget {

  final Snippet cardSnippet;

  const AdminSnippetCardView({Key? key, required this.cardSnippet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(context, MaterialPageRoute(builder: (context) => AdminSnippetDetailFragment(snip: cardSnippet)))
      },
      child: Card(
        child: Column(
          children: [
            ListTile(
              title: Text(cardSnippet.title),
              subtitle: Text(
                cardSnippet.language,
                style: TextStyle(color: Colors.black.withOpacity(0.6)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}