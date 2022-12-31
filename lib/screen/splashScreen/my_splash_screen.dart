import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


import '../../main.dart';
import '../../widget/boxes.dart';
import '../Auth/login.dart';
import '../main_screen.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({super.key});

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  splashScreenTimer() {
    Timer(const Duration(seconds: 2), () async {
      //user is already logged-in
      if (FirebaseAuth.instance.currentUser != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) =>Login()));
        //   context, MaterialPageRoute(builder: (context) => Main()));
      }
      else //user is NOT already logged-in
          {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Login()));
      }
    });
  }

  @override
  void
  initState() //called automatically when user comes here to this splash screen
  {
    super.initState();

    splashScreenTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
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
            ),
          ),
          const CustomSizedBox(height: 10),
          Container(
            decoration: const BoxDecoration(),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset("assets/images/img_2.png"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Insuremart App",
                    style: TextStyle(
                      fontSize: 30,
                      letterSpacing: 3,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
