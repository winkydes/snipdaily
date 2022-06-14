import 'package:flutter/material.dart';

class TypeLabel extends StatefulWidget {
  final String type;
  const TypeLabel({Key? key, required this.type}) : super(key: key);

  @override
  State<TypeLabel> createState() => _LanguageLabelState();
}

class _LanguageLabelState extends State<TypeLabel> {
  BoxDecoration containerDec(Color color) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(16.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(children: [
      Container(
          margin: const EdgeInsets.only(left: 5, right: 5),
          padding: const EdgeInsets.all(10),
          decoration: containerDec(Colors.grey[200]!),
          child: Text(widget.type)),
    ]);
  }
}
