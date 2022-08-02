import 'package:flutter/material.dart';

class InputTextField extends StatefulWidget {
  final int maxLines;
  final String hintText;
  final TextEditingController getTextController;

  const InputTextField(
      {Key? key, required this.maxLines, required this.hintText, required this.getTextController}) : super(key: key);

  @override
  State<InputTextField> createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    widget.getTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.getTextController,
      decoration: InputDecoration(
        labelText: widget.hintText,
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1.0)),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1.0)),
      ),
      maxLines: widget.maxLines,
    );
  }
}
