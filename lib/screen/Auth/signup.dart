import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:insuremart_app/utils/form_validators.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import '../../service/auth_service.dart';
import '../../widget/alert_dialog.dart';
import '../verifyscreen/verifyscreen.dart';
import './login.dart';
import '../../utils/app_theme.dart';
import '../../utils/utils.dart';
import '../../widget/boxes.dart';
import '../../widget/buttons.dart';
import '../../widget/text_fields.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);
  static const route = '/signup';

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController _firstName;
  late TextEditingController _lastName;
  late TextEditingController _email;
  late TextEditingController _password;
  late TextEditingController _cpassword;
  late TextEditingController _title;
  late bool _isObscure;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _firstName = TextEditingController();
    _lastName = TextEditingController();
    _email = TextEditingController();
    _password = TextEditingController();
    _cpassword = TextEditingController();
    _title = TextEditingController();
    _isObscure = true;
  }

  @override
  void dispose() {
    _title.dispose();
    _firstName.dispose();
    _lastName.dispose();
    _email.dispose();
    _password.dispose();
    _cpassword.dispose();
    super.dispose();
  }

  Future<void> _trySubmit({
    required String email,
    required String title,
    required String firstName,
    required String lastName,
    required String password,
  }) async {
    final isValid = _formKey.currentState?.validate();
    if (isValid!) {
      _formKey.currentState?.save();
      final auth = context.read<AuthService>();
      setState(() => isLoading = true);
      auth
          .createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
        title: title.trim(),
        firstname: firstName.trim(),
        lastname: lastName.trim(),
      )
          .then((user) {
        setState(() => isLoading = false);
        if (user != null) {
          log(user.uid);
          Toast.show('Successfully sign-up', gravity: Toast.top);
          // Future.delayed(const Duration(seconds: 2));
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>VerifyScreen()));
          //     .pushNamedAndRemoveUntil(Main.route, (route) => false);
        } else {
          showDialog(
            context: context,
            builder: (_) => MyAlertDialog(
              title: 'Error',
              content: auth.authErrorMsg,
            ),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Create your account'),
          titleSpacing: 0,
          centerTitle: true,
          leadingWidth: 64,
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              const CustomSizedBox(height: 15),
              label('Title'),
              CustomDropDownButton(
                label: 'title',
                focusColor: InsuremartTheme.blue2,
                items: Utils.titleList,
                onChanged: (String? val) {
                  _title.text = val!;
                },
              ),
              const CustomSizedBox(height: 15),
              label('First Name'),
              CustomTextField(
                controller: _firstName,
                validator: (value) {
                  _firstName.text = value;
                  if (value == null || value.isEmpty) {
                    return 'Please enter firstname';
                  }
                  return null;
                },
              ),
              const CustomSizedBox(height: 25),
              label('Last Name'),
              CustomTextField(
                controller: _lastName,
                validator: (value) {
                  _lastName.text = value;
                  if (value == null || value.isEmpty) {
                    return 'Please enter lastname';
                  }
                  return null;
                },
              ),
              const CustomSizedBox(height: 25),
              label('Email Address'),
              CustomTextField(
                controller: _email,
                validator: (value) => FormValidators.validateEmail(value),
              ),
              const CustomSizedBox(height: 25),
              label('Password'),
              CustomTextField(
                controller: _password,
                obscureText: _isObscure,
                validator: (value) => FormValidators.validatePassword(value),
                suffix: IconButton(
                  icon: Icon(
                    // Based on passwordVisible state choose the icon
                    _isObscure ? Icons.visibility : Icons.visibility_off,
                    color: InsuremartTheme.green2,
                  ),

                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                  //color: InsuremartTheme.black1.withOpacity(.6),
                  // icon: const Icon(Icons.visibility),
                ),
              ),
              const CustomSizedBox(height: 25),
              label('Re-enter Password'),
              CustomTextField(
                controller: _cpassword,
                obscureText: _isObscure,
                validator: (value) =>
                    FormValidators.validateCPassword(_password.text, value),
                suffix: IconButton(
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      _isObscure ? Icons.visibility : Icons.visibility_off,
                      color: InsuremartTheme.green2,
                    ),
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    }),
              ),
              const CustomSizedBox(height: 25),
              AuthButton(
                onPressed: () => _trySubmit(
                  email: _email.text,
                  title: _title.text,
                  firstName: _firstName.text,
                  lastName: _lastName.text,
                  password: _password.text,
                ),
                title: 'Sign Up',
                loadingTitle: 'Creating your account....',
                // isLoading: true,
              ),
              const CustomSizedBox(height: 25),
              Text(
                'Or login with',
                style: InsuremartTheme.lightTextTheme.bodyText1!
                    .copyWith(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const CustomSizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: const Color(0xfff4f4f4),
                    child: IconButton(
                      onPressed: () {},
                      color: const Color(0xff3B5998),
                      icon: const Icon(FontAwesomeIcons.squareFacebook),
                    ),
                  ),
                  const CustomSizedBox(width: 20),
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: const Color(0xfff4f4f4),
                    child: IconButton(
                      onPressed: () {},
                      color: const Color(0xffDB4437),
                      icon: const Icon(FontAwesomeIcons.google),
                    ),
                  ),
                ],
              ),
              const CustomSizedBox(height: 36.29),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: InsuremartTheme.lightTextTheme.headline3!
                        .copyWith(color: InsuremartTheme.black1),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pushNamed(Login.route),
                    child: Text(
                      'Sign In',
                      style: InsuremartTheme.lightTextTheme.headline3!
                          .copyWith(color: InsuremartTheme.green1),
                    ),
                  ),
                ],
              ),
              const CustomSizedBox(height: 70.83),
            ],
          ),
        ),
      ),
    );
  }

  void alertDiaglog(
      BuildContext context, String title, String statement, String btn) {
    Widget okButton = CloseButton(
      color: Colors.blueAccent,
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(statement),
      actions: [
        okButton,
      ],
    );
  }
}

void buildDisMissButton(BuildContext context) {
  Widget okButton = CloseButton(
    color: Colors.blueAccent,
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
}

void showToast(String msg, {int? duration, int? gravity}) {
  Toast.show(msg, duration: duration, gravity: gravity);
}
