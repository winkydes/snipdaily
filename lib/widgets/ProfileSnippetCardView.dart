import 'package:flutter/material.dart';
import 'package:snipdaily/assets/constants.dart';
import '../backend/models.dart';
import '../fragments/PersonalSnippetDetailFragment.dart';

class ProfileSnippetCardView extends StatefulWidget {

  final Snippet cardSnippet;

  const ProfileSnippetCardView({Key? key, required this.cardSnippet}) : super(key: key);

  @override
  State<ProfileSnippetCardView> createState() => _ProfileSnippetCardViewState();
}

class _ProfileSnippetCardViewState extends State<ProfileSnippetCardView> {

  Icon verfiedIcon(verified) {
    switch (verified) {
      case REJECTED: {
        return const Icon(Icons.close, color: Colors.red);
      }
      case VERIFIED: {
        return const Icon(Icons.check, color: Colors.green);
      }
      case NOT_VERIFIED: {
        return const Icon(Icons.pending, color: Colors.grey);
      }
      default: {
        return const Icon(Icons.error);
      }
    }
  }

  Text verifiedText(String verified) {
    switch (verified) {
      case REJECTED:
      case VERIFIED: {
        return Text(verified.toUpperCase());
      }
      case NOT_VERIFIED: {
        return const Text("PENDING");
      }
      default: {
        return const Text("Error");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(context, MaterialPageRoute(builder: (context) => PersonalSnippetDetailFragment(snip: widget.cardSnippet)))
      },
      child: Card(
        child:Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.cardSnippet.title,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.bold)
                    ),
                    Text(
                      "${widget.cardSnippet.liked.length} 🔥  ${widget.cardSnippet.language}",
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  verifiedText(widget.cardSnippet.verified),
                  verfiedIcon(widget.cardSnippet.verified),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}