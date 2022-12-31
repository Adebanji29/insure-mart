import 'package:flutter/material.dart';

import '../../utils/app_theme.dart';
import '../../widget/text_fields.dart';
import '../../widget/buttons.dart';

class Bvn extends StatefulWidget {
  const Bvn({Key? key}) : super(key: key);
  static const route = '/bvn';

  @override
  State<Bvn> createState() => _BvnState();
}

class _BvnState extends State<Bvn> {
  late TextEditingController _bvn;
  @override
  void initState() {
    _bvn = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _bvn.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit Profile'),
          titleSpacing: 0,
          centerTitle: false,
          leadingWidth: 64,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              label('BVN'),
              CustomTextField(
                label: '11-digit number',
                focusColor: InsuremartTheme.blue2,
                controller: _bvn,
                maxLength: 11,
              ),
              const SizedBox(height: 25),
              LongButton(title: 'SAVE', onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
