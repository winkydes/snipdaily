import 'package:flutter/material.dart';

class BackableAppBar extends StatelessWidget with PreferredSizeWidget {
  final Text title;
  final AppBar appBar;
  final List<Widget> widgets;

  const BackableAppBar({Key? key, required this.title, required this.appBar, required this.widgets }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title,
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 174, 123, 241),
      actions: widgets,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}