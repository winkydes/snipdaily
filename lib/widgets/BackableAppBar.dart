import 'package:flutter/material.dart';

class BackableAppBar extends StatelessWidget with PreferredSizeWidget {
  final Text title;
  final AppBar appBar;
  final List<Widget> widgets;
  final BuildContext pageContext;

  const BackableAppBar({Key? key, required this.title, required this.appBar, required this.widgets, required this.pageContext }) : super(key: key);

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
              Navigator.pop(pageContext);
            },
          ),
          title,
        ],
      ),
      actions: widgets,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}