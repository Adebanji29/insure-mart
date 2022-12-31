import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import '../../service/auth_service.dart';
import '../../utils/app_theme.dart';
import '../../widget/alert_dialog.dart';
import '../../widget/boxes.dart';
import '../../widget/buttons.dart';
import '../../widget/text_fields.dart';
import '../main_screen.dart';
import 'forget_password.dart';
import 'signup.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  static const route = '/login';

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController _email;
  late TextEditingController _password;
  bool _isObscure = true;
  bool _isLoading = false;
  // late ProgressBar _sendingMsgProgressBar;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _email = TextEditingController();
    _password = TextEditingController();
    // _sendingMsgProgressBar = ProgressBar();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _isLoading = false;
    // _sendingMsgProgressBar.hide();
    super.dispose();
  }

  void _trySubmit(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final auth = context.read<AuthService>();
      setState(() {
        _isLoading = true;
      });
      await auth.signInWithEmailAndPassword(email.trim(), password.trim()).then(
        (user) {
          if (user != null) {
            log(user.uid);
            Toast.show('Successfully sign-in', gravity: Toast.top);
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) =>Main()));
                // .pushNamedAndRemoveUntil(Main.route, (route) => false);
          } else {
            showDialog(
              context: context,
              builder: (_) => MyAlertDialog(
                title: 'Error',
                content: auth.authErrorMsg,
              ),
            ).then((value) => setState(() => _isLoading = false));
            
          }
        },
      );
    }
  }

  // void showSendingProgressBar() {
  //   _sendingMsgProgressBar.show(context);
  // }

  // void hideSendingProgressBar() {
  //   _sendingMsgProgressBar.hide();
  // }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              const CustomSizedBox(height: 74),
              Container(
                alignment: AlignmentDirectional.center,
                child: Image.asset(
                  'assets/images/img.png',
                  width: 130,
                  height: 88,
                  fit: BoxFit.cover,
                ),
              ),
              const CustomSizedBox(height: 20),
              Text(
                'Welcome!',
                style: InsuremartTheme.lightTextTheme.bodyText1!
                    .copyWith(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const CustomSizedBox(height: 20),
              label('Email'),
              CustomTextField(
                controller: _email,
                // validator: ,
                validator: (value) {
                  // username = value;
                  if (value.isEmpty ||
                      !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                    return 'Enter a valid email!';
                  }
                  return null;
                },
                label: 'Email',
                keyBoardType: TextInputType.emailAddress,
              ),
              const CustomSizedBox(height: 25),
              label('Password'),
              CustomTextField(
                controller: _password,
                obscureText: _isObscure,
                validator: (value) {
                  if (value.isEmpty) return 'Enter a valid password!';
                  return null;
                },
                label: 'Password',
                //keyBoardType: TextInputType.,
                suffix: IconButton(
                  icon: Icon(
                    // Based on passwordVisible state choose the icon
                    _isObscure ? Icons.visibility : Icons.visibility_off,
                    color: Theme.of(context).primaryColorDark,
                  ),
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                  // icon: const Icon(Icons.visibility),
                ),
              ),
              const CustomSizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () =>
                      Navigator.of(context).pushNamed(ForgetPassword.route),
                  child: Text(
                    'Forgot Password',
                    style: InsuremartTheme.lightTextTheme.headline1!.copyWith(
                      fontSize: 14,
                      color: InsuremartTheme.green1,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
              const CustomSizedBox(height: 25),
              AuthButton(
                title: 'Login',
                isLoading: _isLoading,
                onPressed: () {
                  _trySubmit(_email.text, _password.text);
                },
                loadingTitle: 'Login you in...',
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
                      onPressed: () =>
                          context.read<AuthService>().signInWithFaceBook(),
                      color: const Color(0xff3B5998),
                      icon: const Icon(FontAwesomeIcons.squareFacebook),
                    ),
                  ),
                  const CustomSizedBox(width: 20),
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: const Color(0xfff4f4f4),
                    child: IconButton(
                      onPressed: () =>
                          context.read<AuthService>().signInWithGoogle(),
                      color: const Color(0xffDB4437),
                      icon: const Icon(FontAwesomeIcons.google),
                    ),
                  ),
                ],
              ),
              const CustomSizedBox(height: 22),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have any account?',
                    style: InsuremartTheme.lightTextTheme.headline3!
                        .copyWith(color: InsuremartTheme.black1),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pushNamed(SignUp.route),
                    child: Text(
                      'Sign Up',
                      style: InsuremartTheme.lightTextTheme.headline3!
                          .copyWith(color: InsuremartTheme.green1),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Future<void> _submit(BuildContext context) async {
//   //var init = ToastContext.init(context);
//   //isLoading = true;

//   // const CustomLinearProgressIndicator( max: 100.0, current: 10.0, color: InsuremartTheme.blue1,);
//   username = _email.text;
//   password = _password.text;
//   final isValid = _formKey.currentState?.validate();
//   if (!isValid!) {
//     return;
//   } else {
//     _formKey.currentState?.save();
//     await dbHelper.getLoginUser(username, password).then((userData) {
//       showToast("Successfully Signed up", gravity: Toast.bottom);

//       Navigator.of(context)
//           .pushNamedAndRemoveUntil(Main.route, (route) => false);
//       hideSendingProgressBar();
//     }).catchError((error) {
//       if (kDebugMode) {
//         print(error);
//       }
//       print("Error: Data save failed $error");
//     });
//     if (kDebugMode) {
//       print("user name is  $username and password is  $password ");
//     }
//   }
// }
