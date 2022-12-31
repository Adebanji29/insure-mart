import 'package:flutter/material.dart';


import '../../utils/color.dart';
import '../../widget/buttons.dart';
import '../../widget/text_fields.dart';

class PhoneNumber extends StatefulWidget {
  const PhoneNumber({Key? key}) : super(key: key);
  static const route = '/phoneNumber';

  @override
  State<PhoneNumber> createState() => _PhoneNumberState();
}

class _PhoneNumberState extends State<PhoneNumber> {
  late TextEditingController _phoneNumber;
  late TextEditingController _otp;
  @override
  void initState() {
    _phoneNumber = TextEditingController();
    _otp = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _phoneNumber.dispose();
    _otp.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Phone Number'),
          titleSpacing: 0,
          centerTitle: false,
          leadingWidth: 64,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              label('Phone Number'),
              CustomTextField(
                label: 'Phone number',
                controller: _phoneNumber,
                keyBoardType: TextInputType.phone,
              ),
              const SizedBox(height: 25),
              LongButton(title: 'SEND OTP', onPressed: () {}),
              const SizedBox(height: 25),
              label('OTP', color: InsuremartColor.black1.withOpacity(.3)),
              CustomTextField(
                label: '6-digit code',
                controller: _phoneNumber,
                keyBoardType: TextInputType.number,
              ),
              const SizedBox(height: 25),
              const LongButton(title: 'VERIFY & SAVE', onPressed: null),
            ],
          ),
        ),
      ),
    );
  }
}
