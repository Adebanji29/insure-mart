import 'package:flutter/material.dart';

import '../../widget/text_fields.dart';
import '../../widget/boxes.dart';
import '../../widget/buttons.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);
  static const route = 'changePassword';

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _currentPassword;
  late TextEditingController _newPassword;
  late TextEditingController _cNewPassword;
  @override
  void initState() {
    _currentPassword = TextEditingController();
    _newPassword = TextEditingController();
    _cNewPassword = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _currentPassword.dispose();
    _newPassword.dispose();
    _cNewPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Change Password'),
          titleSpacing: 0,
          centerTitle: false,
          leadingWidth: 64,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                label('Current Password'),
                CustomTextField(
                  label: 'Current Password',
                  controller: _currentPassword,
                  suffix: IconButton(
                    icon: const Icon(Icons.visibility),
                    onPressed: () {},
                  ),
                ),
                const CustomSizedBox(height: 25),
                label('New Password'),
                CustomTextField(
                  label: 'New Password',
                  controller: _newPassword,
                  suffix: IconButton(
                    icon: const Icon(Icons.visibility),
                    onPressed: () {},
                  ),
                ),
                const CustomSizedBox(height: 25),
                label('Re-enter New Password'),
                CustomTextField(
                  label: 'Re-enter New Password',
                  controller: _cNewPassword,
                  suffix: IconButton(
                    icon: const Icon(Icons.visibility),
                    onPressed: () {},
                  ),
                ),
                const CustomSizedBox(height: 25),
                LongButton(title: 'CHANGE & SAVE', onPressed: () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
