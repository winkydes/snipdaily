import 'package:flutter/material.dart';

class LanguageLabel extends StatefulWidget {
  final String language;
  const LanguageLabel({Key? key, required this.language}) : super(key: key);

  @override
  State<LanguageLabel> createState() => _LanguageLabelState();
}

class _LanguageLabelState extends State<LanguageLabel> {
  BoxDecoration containerDec(Color color) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(16.0),
    );
  }

  Widget label(String type) {
    switch (type) {
      case 'C++':
        return Wrap(children: [
          Container(
              margin: const EdgeInsets.only(left: 5, right: 5),
              padding: const EdgeInsets.only(left:10, right: 10, top: 5, bottom: 5),
              decoration: containerDec(Colors.blue[300]!),
              child: const Text('C++', style: TextStyle(color: Colors.black))),
        ]);
      case 'JavaScript':
        return Wrap(children: [
          Container(
              margin: const EdgeInsets.only(left: 5, right: 5),
              padding: const EdgeInsets.only(left:10, right: 10, top: 5, bottom: 5),
              decoration: containerDec(Colors.yellow[300]!),
              child: const Text('JavaScript', style: TextStyle(color: Colors.black))),
        ]);
      case 'Python':
        return Wrap(children: [
          Container(
              margin: const EdgeInsets.only(left: 5, right: 5),
              padding: const EdgeInsets.only(left:10, right: 10, top: 5, bottom: 5),
              decoration: containerDec(Colors.green[300]!),
              child: const Text('Python', style: TextStyle(color: Colors.black))),
        ]);
      default:
        {
          return Wrap(children: [
            Container(
                margin: const EdgeInsets.only(left: 5, right: 5),
                padding: const EdgeInsets.only(left:10, right: 10, top: 5, bottom: 5),
                decoration: containerDec(Colors.white),
                child: Text(type, style: const TextStyle(color: Colors.black))),
          ]);
        }
    }
    ;
  }

  @override
  Widget build(BuildContext context) {
    return label(widget.language);
  }
}
