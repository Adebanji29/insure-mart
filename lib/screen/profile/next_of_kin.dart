import 'package:flutter/material.dart';

import '../../widget/text_fields.dart';
import '../../widget/boxes.dart';
import '../../widget/buttons.dart';

class NextofKin extends StatefulWidget {
  const NextofKin({Key? key}) : super(key: key);
  static const route = '/nextKin';

  @override
  State<NextofKin> createState() => _NextofKinState();
}

class _NextofKinState extends State<NextofKin> {
  final List<String> _relTypeList = ['Mother', 'Father'];
  late TextEditingController _fName;
  late TextEditingController _lName;
  late TextEditingController _relType;
  late TextEditingController _email;
  late TextEditingController _pNumber;
  @override
  void initState() {
    _fName = TextEditingController();
    _lName = TextEditingController();
    _relType = TextEditingController();
    _email = TextEditingController();
    _pNumber = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _fName.dispose();
    _lName.dispose();
    _relType.dispose();
    _email.dispose();
    _pNumber.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Next of kin'),
          titleSpacing: 0,
          centerTitle: false,
          leadingWidth: 64,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              label('First Name'),
              CustomTextField(label: 'First Name', controller: _fName),
              const CustomSizedBox(height: 25),
              label('Last Name'),
              CustomTextField(label: 'Last Name', controller: _lName),
              const CustomSizedBox(height: 25),
              label('Relationship Type'),
              CustomDropDownButton(
                label: 'eg. Mother',
                items: _relTypeList,
                onChanged: (val) {
                  _relType.text = val!;
                },
              ),
              const CustomSizedBox(height: 25),
              label('Last Name'),
              CustomTextField(label: 'Email Address', controller: _email),
              const CustomSizedBox(height: 25),
              label('Last Name'),
              CustomTextField(label: 'Phone Number', controller: _pNumber),
              const CustomSizedBox(height: 25),
              LongButton(title: 'SAVE', onPressed: () {})
            ],
          ),
        ),
      ),
    );
  }
}
