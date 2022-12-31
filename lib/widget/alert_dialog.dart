import 'package:flutter/material.dart';

class MyAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final List<Widget> actions;

  const MyAlertDialog({
    super.key,
    required this.title,
    required this.content,
    this.actions = const [],
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline2,
      ),
      actions: actions,
      content: Text(
        content,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
