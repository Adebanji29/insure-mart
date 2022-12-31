import 'package:flutter/material.dart';


import '../../utils/app_theme.dart';
import '../../widget/boxes.dart';
import '../../widget/buttons.dart';
import '../../widget/text_fields.dart';
import './success_forgot_password.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);
  static const route = '/forgetPassword';

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  late TextEditingController _email;
  bool _isSuccessful = false;
  @override
  void initState() {
    _email = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot password?'),
        titleSpacing: 0,
        centerTitle: true,
        leadingWidth: 64,
      ),
      body: !_isSuccessful
          ? ListView(
              padding: const EdgeInsets.only(
                  right: 20, left: 20, top: 200, bottom: 40),
              children: [
                label('Email Address'),
                CustomTextField(controller: _email),
                const CustomSizedBox(height: 25),
                AuthButton(
                  onPressed: () {
                    setState(() {
                      _isSuccessful = true;
                    });
                  },
                  title: 'Continue',
                  loadingTitle: 'Please wait...',
                  // isLoading: true,
                ),
                const CustomSizedBox(height: 200),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Remembered? ',
                      style: InsuremartTheme.lightTextTheme.headline3!
                          .copyWith(color: InsuremartTheme.black1),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Text(
                        'Login',
                        style: InsuremartTheme.lightTextTheme.headline3!
                            .copyWith(color: InsuremartTheme.green1),
                      ),
                    ),
                  ],
                ),
              ],
            )
          : const ForgotPasswordSuccess(),
    );
  }
}
