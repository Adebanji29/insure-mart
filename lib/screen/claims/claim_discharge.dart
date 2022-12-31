import 'package:flutter/material.dart';

import '../../widget/buttons.dart';
import '../../widget/text_fields.dart';

class ClaimDischarge extends StatefulWidget {
  const ClaimDischarge({Key? key}) : super(key: key);
  static const route = '/claimDischarge';

  @override
  State<ClaimDischarge> createState() => _ClaimDischargeState();
}

class _ClaimDischargeState extends State<ClaimDischarge> {
  String? value;
  final _items = ['item1', 'item2', 'item3', 'item4', 'item5', 'item6'];
  late GlobalKey<FormState> _formKey;
  late TextEditingController _payeeName;
  late TextEditingController _accountNumber;
  late TextEditingController _accountName;
  late TextEditingController _bankSortCode;
  late TextEditingController _bankBranch;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _payeeName = TextEditingController();
    _accountNumber = TextEditingController();
    _accountName = TextEditingController();
    _bankSortCode = TextEditingController();
    _bankBranch = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _payeeName.dispose();
    _accountNumber.dispose();
    _accountName.dispose();
    _bankSortCode.dispose();
    _bankBranch.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Claim Discharge'),
          titleSpacing: 0,
          centerTitle: false,
          leadingWidth: 64,
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 136),
            children: [
              label('Payee Name'),
              CustomTextField(controller: _payeeName, label: 'Payee Name'),
              const SizedBox(height: 25),
              label('Bank Name'),
              CustomDropDownButton(
                items: _items,
                onChanged: (val) {},
                label: 'Bank Name',
              ),
              const SizedBox(height: 25),
              label('Account Number'),
              CustomTextField(
                  controller: _accountNumber, label: 'Account Number'),
              const SizedBox(height: 25),
              label('Account Name'),
              CustomTextField(controller: _accountName, label: 'Account Name'),
              const SizedBox(height: 25),
              label('Bank Sort Code (optional)'),
              CustomTextField(
                  controller: _bankSortCode, label: 'Bank Sort Code'),
              const SizedBox(height: 25),
              label('Bank Branch (optional)'),
              CustomTextField(controller: _bankBranch, label: 'Bank Branch'),
              const SizedBox(height: 25),
              LongButton(title: 'DISCHARGE CLAIM', onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
