import 'package:flutter/material.dart';

class HelpSupport extends StatelessWidget {
  const HelpSupport({Key? key}) : super(key: key);
  static const route = '/helpSupport';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & Support'),
        titleSpacing: 0,
        centerTitle: false,
        leadingWidth: 64,
      ),
    );
  }
}
