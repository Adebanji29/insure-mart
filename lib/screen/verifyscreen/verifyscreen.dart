import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../widget/boxes.dart';
import '../Auth/login.dart';


class VerifyScreen extends StatefulWidget {
  const VerifyScreen({super.key});

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final auth = FirebaseAuth.instance;
  User? user;
  Timer? timer;

  @override
  void initState() {
    user = auth.currentUser;
    user?.sendEmailVerification();

    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      checkEmailVerified();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SizedBox(
            height: 270,
            width: MediaQuery.of(context).size.width * 0.70,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    alignment: AlignmentDirectional.center,
                    child: Image.asset(
                      'assets/images/img.png',
                      width: 130,
                      height: 88,
                      fit: BoxFit.cover,
                    )),
                const CustomSizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: 300,
                  height: 100,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: const [
                        Expanded(
                          child: Text(
                              "A verification link has been sent to your email",
                              style: TextStyle(fontSize: 15),
                              textAlign: TextAlign.center),
                        ),
                        Expanded(
                          child: Text(
                              "Kindly verify your email to proceed to login",
                              style: TextStyle(fontSize: 15),
                              textAlign: TextAlign.center),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> checkEmailVerified() async {
    final myContext = Navigator.of(context);
    user = auth.currentUser;
    await user?.reload();
    if (user!.emailVerified) {
      timer?.cancel;
      myContext.pushReplacement(
          MaterialPageRoute(builder: (context) => const Login()));
    }
  }
}
