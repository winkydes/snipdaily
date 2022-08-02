import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../assets/constants.dart';
import '../../backend/models.dart';
import '../../widgets/SnippetCardView.dart';

class SearchFragment extends StatefulWidget {
  const SearchFragment({Key? key}) : super(key: key);

  @override
  State<SearchFragment> createState() => _SearchFragmentState();
}

class _SearchFragmentState extends State<SearchFragment> {

  late final Stream<Iterable<Snippet>> _snippetStream = FirebaseFirestore
      .instance
      .collection('snippets')
      .where("verified", isEqualTo: VERIFIED)
      .snapshots()
      .map((item) => item.docs.map((doc) => Snippet.fromSnapshot(doc)));

  late final List<Snippet> snippetList = [];
  late List<Snippet> searchResult = [];

  var searchController = TextEditingController();

  void onSearchTextChanged(String text) async {
    searchResult.clear();
    if (text.isEmpty && mounted) {
      setState(() {});
      return;
    }
    snippetList.forEach((snip) {
      if (snip.title.toLowerCase().contains(text) || snip.title.contains(text)) {
        searchResult.add(snip);
      }
    });
    if (mounted) {
      setState(() {});
    }
  }

  // initialize snippetList for rendering in screen
  @override
  void initState() {
    _snippetStream.forEach((element) => {
          element.forEach((snip) => snippetList.add(snip))
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // The search area here
        title: SizedBox(
          width: double.infinity,
          height: 40,
          child: Center(
            child: TextField(
              controller: searchController,
              onChanged: (value) {onSearchTextChanged(value);},
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 5),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    /* Clear the search field */
                    searchController.clear();
                    onSearchTextChanged('');
                  },
                ),
                hintText: 'Search...',
                fillColor: Theme.of(context).backgroundColor,
                border: InputBorder.none),
            ),
          ),
        ),
      ),
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
          if (!snapshot.hasData) {
            return const Center(
              child: Text(
                'There are no snippets related to this topic yet, please wait for an update to the database.',
                textAlign: TextAlign.center,
              ),
            );
          }
          if (searchResult.isEmpty && searchController.text.isNotEmpty) {
            return const Center(
              child: Text('There are no snippets related to your search, please try again.'),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: searchResult.length,
            itemBuilder: (context, index) {
              return SnippetCardView(cardSnippet: searchResult[index],);
            }
          );
        }
      ),
    );
  }
}