import 'package:flutter/material.dart';

class SettingsItemWidget extends StatelessWidget {
  const SettingsItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Theme.of(context).colorScheme.outline,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        child: const SizedBox(
          width: 200,
          height: 50,
          child: Center(child: Text('Change Preference')),
        ),
    );
  }
}