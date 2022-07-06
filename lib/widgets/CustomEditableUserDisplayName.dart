import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:flutterfire_ui/i10n.dart';

class CustomEditableUserDisplayName extends StatefulWidget {
  const CustomEditableUserDisplayName({Key? key}) : super(key: key);

  @override
  State<CustomEditableUserDisplayName> createState() => _CustomEditableUserDisplayNameState();
}

class _CustomEditableUserDisplayNameState extends State<CustomEditableUserDisplayName> {
  String? get displayName => FirebaseAuth.instance.currentUser?.displayName;

  late final ctrl = TextEditingController(text: displayName ?? '');
  late bool _editing = displayName == null;
  bool _isLoading = false;

  void _onEdit() {
    setState(() {
      _editing = true;
    });
  }

  Future<void> _finishEditing() async {
    try {
      if (displayName == ctrl.text) return;
      await FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).update({"displayName": ctrl.text});
      setState(() {
        _isLoading = true;
      });

      await FirebaseAuth.instance.currentUser?.updateDisplayName(ctrl.text);
      await FirebaseAuth.instance.currentUser?.reload();
    } finally {
      setState(() {
        _editing = false;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l = FlutterFireUILocalizations.labelsOf(context);
    Widget iconButton = IconButton(
        icon: Icon(_editing ? Icons.check : Icons.edit),
        color: theme.colorScheme.secondary,
        onPressed: _editing ? _finishEditing : _onEdit,
    );

    if (!_editing) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.5),
        child: IntrinsicWidth(
          child: Row(
            children: [
              Text(displayName ?? 'Unknown'),
              iconButton,
            ],
          ),
        ),
      );
    }

    Widget textField = TextField(
        autofocus: true,
        controller: ctrl,
        decoration: InputDecoration(hintText: l.name, labelText: l.name),
        onSubmitted: (_) => _finishEditing(),
    );

    return Row(
      children: [
        Expanded(child: textField),
        const SizedBox(width: 8),
        SizedBox(
          width: 50,
          height: 32,
          child: Stack(
            children: [
              if (_isLoading)
                const LoadingIndicator(size: 24, borderWidth: 1)
              else
                Align(
                  alignment: Alignment.topLeft,
                  child: iconButton,
                ),
            ],
          ),
        ),
      ],
    );
  }
}