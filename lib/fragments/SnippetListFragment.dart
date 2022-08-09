import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:snipdaily/assets/constants.dart';
import 'package:snipdaily/widgets/SnippetCardView.dart';
import '../backend/models.dart';

class SnippetListFragment extends StatefulWidget {
  final String type;
  const SnippetListFragment({Key? key, required this.type}) : super(key: key);

  @override
  State<SnippetListFragment> createState() => _SnippetListFragmentState();
}

class _SnippetListFragmentState extends State<SnippetListFragment> {
  String sortType = 'trending';
  int pageLength = 10;
  int currentPageNum = 1;
  // take data from firebase in the form of Stream<Iterable<Snippet>>
  late final Stream<Iterable<Snippet>> _snippetStream = FirebaseFirestore
      .instance
      .collection('snippets')
      .where("type", isEqualTo: widget.type) 
      .where("verified", isEqualTo: VERIFIED)
      .snapshots()
      .map((item) => item.docs.map((doc) => Snippet.fromSnapshot(doc)));

  late final List<SnippetCardView> snippetList = [];

  List<SnippetCardView> sortByDate(List<SnippetCardView> snipList) {
    snipList.sort((a, b) => b.cardSnippet.date.compareTo(a.cardSnippet.date));
    return snipList.sublist((currentPageNum-1) * pageLength, (currentPageNum-1) * pageLength + pageLength < snipList.length ? (currentPageNum-1) * pageLength + pageLength : snipList.length);
  }

  List<SnippetCardView> sortByPopularity(List<SnippetCardView> snipList) {
    snipList.sort((a, b) => b.cardSnippet.liked.length.compareTo(a.cardSnippet.liked.length));
    return snipList.sublist((currentPageNum-1) * pageLength, (currentPageNum-1) * pageLength + pageLength < snipList.length ? (currentPageNum-1) * pageLength + pageLength : snipList.length);
  }

  List<Row> pageButton() {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          (currentPageNum == 1?
            const SizedBox.shrink() : 
            TextButton(
              onPressed: () { 
                setState(() {
                  currentPageNum --;
                });
              },
              child: const Text("Previous page"),
            )
          ),
          (currentPageNum == (snippetList.length/pageLength).ceil()?
            const SizedBox.shrink() : 
            TextButton(
              onPressed: () { 
                setState(() {
                  currentPageNum ++;
                });
              },
              child: const Text("Next page"),
            )
          ),
          
        ],
      )
    ];
  }

  // initialize snippetList for rendering in screen
  @override
  void initState() {
    _snippetStream.forEach((element) => {
          element.forEach((snip) => snippetList.add(SnippetCardView(
                cardSnippet: snip,
              )))
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.type)),
        body: StreamBuilder<Iterable<Snippet>>(
            stream: _snippetStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text('Something went wrong'),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snippetList.isEmpty) {
                return const Center(
                  child: Text(
                    'There is no snippets related to this topic yet, please wait for an update to the database.',
                    textAlign: TextAlign.center,
                  ),
                );
              }
              snippetList.sort((a, b) => b.cardSnippet.liked.length.compareTo(a.cardSnippet.liked.length));
              return ListView(
                  padding: const EdgeInsets.only(
                      left: 30, right: 30, top: 30, bottom: 30),
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        if (sortType == 'trending') {
                          setState(() {
                            sortType = 'newest';
                          });
                        } else {
                          setState(() {
                            sortType = 'trending';
                          });
                        }
                        
                      },
                      child: Container(
                        margin: const EdgeInsets.only(left: 5),
                        child: Text(sortType == 'trending' ? "Sort by popularity": "Sort from newest to oldest", style: const TextStyle(fontWeight: FontWeight.bold),)
                      ),
                    ),
                  ] + (sortType == 'trending' ? sortByPopularity(snippetList): sortByDate(snippetList))
                   + (snippetList.length > pageLength? pageButton() : [const SizedBox.shrink()]));
            }),
    );
  }
}
