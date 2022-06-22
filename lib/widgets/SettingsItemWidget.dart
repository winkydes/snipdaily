import 'package:flutter/material.dart';

class SettingsItemWidget extends StatelessWidget {

  final String name;
  final Function onTapAction;

  const SettingsItemWidget({Key? key, required this.name, required this.onTapAction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTapAction(),
      child: Card(
        shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Theme.of(context).colorScheme.outline,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
          child: SizedBox(
            width: 200,
            height: 50,
            child: Center(child: Text(name)),
          ),
      ),
    );
  }
}