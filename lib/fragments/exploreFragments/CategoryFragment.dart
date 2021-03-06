import 'package:flutter/material.dart';
import '../SnippetListFragment.dart';

class CategoryFragment extends StatefulWidget {
  const CategoryFragment({Key? key}) : super(key: key);

  @override
  State<CategoryFragment> createState() => _CategoryFragmentState();
}

GestureDetector customContainer(
    String type, Color? cardColor, BuildContext context) {
  return GestureDetector(
    onTap: (() => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SnippetListFragment(type: type)))),
    child: Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              cardColor!,
              Colors.purple[200]!,
            ],
          )),
      padding: const EdgeInsets.all(8),
      child: Center(
          child: Text(
        type,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
        textAlign: TextAlign.center,
      )),
    ),
  );
}

class _CategoryFragmentState extends State<CategoryFragment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Categories"),),
      body: GridView.count(
        primary: false,
        padding: const EdgeInsets.only(left: 30, right:30, bottom: 30, top: 25),
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        crossAxisCount: 2,
        children: <Widget>[
          customContainer('General', Colors.blue[200], context),
          customContainer('Data Structure', Colors.red[200], context),
          customContainer('Web/App Development', Colors.green[200], context),
          customContainer('Data Science', Colors.yellow[200], context),
          customContainer('Algorithms and Logic', Colors.grey[200], context),
          customContainer('Articles', Colors.orange[200], context),
        ],
      ),
    );
  }
}
