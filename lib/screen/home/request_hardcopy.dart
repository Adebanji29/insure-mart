import 'package:flutter/material.dart';

import '../../widget/buttons.dart';
import '../../widget/text_fields.dart';


class RequestHardcopy extends StatefulWidget {
  const RequestHardcopy({Key? key}) : super(key: key);
  static const route = '/requestHardCopy';

  @override
  State<RequestHardcopy> createState() => _RequestHardcopyState();
}

class _RequestHardcopyState extends State<RequestHardcopy> {
  late TextEditingController _dAddress;
  late TextEditingController _cName;
  late TextEditingController _cNumber;

  @override
  void initState() {
    _dAddress = TextEditingController();
    _cName = TextEditingController();
    _cNumber = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _dAddress.dispose();
    _cName.dispose();
    _cNumber.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Request for hard copy'),
          titleSpacing: 0,
          centerTitle: false,
          leadingWidth: 64,
        ),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 344),
          children: [
            label('Delivery address'),
            CustomTextField(
              controller: _dAddress,
              label: 'Delivery address',
            ),
            const SizedBox(height: 25),
            label('Contact name'),
            CustomTextField(
              controller: _cName,
              label: 'Contact name',
            ),
            const SizedBox(height: 25),
            label('Contact number'),
            CustomTextField(
              controller: _cNumber,
              label: 'Contact number',
            ),
            const SizedBox(height: 25),
            LongButton(title: 'REQUEST', onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
