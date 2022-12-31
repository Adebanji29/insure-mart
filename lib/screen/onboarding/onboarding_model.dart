import 'package:flutter/material.dart';

class OnboardModel{
  String img;
  String text;
  String desc;
  Widget bg;
  Color button;
  String bttext;

  OnboardModel({
    required this.img,
    required this.text,
    required this.desc,
    required this.bg,
    required this.button,
    required this.bttext,

  });
}
List<OnboardModel>screens = <OnboardModel>[
  OnboardModel(
      img: "assets/images/img_1.png",
      text: "Easy and Personalized Insurance",
      desc: "We offer easy, flexible and tailored-to-fit insurance products",
      bg: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color(0xff03588C),
                Color(0xff213267),
              ],
            )
        ),
      ),
      button: Colors.white,
      bttext: "NEXT"

  ),


  OnboardModel(
    img: "assets/images/img_2.png",
    text: "True Customer Centricity",
    desc: "We are passionate about providing our customers with a unique and enriched insurance experience",
    bg: Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xff03588C),
              Color(0xff213267),
            ],
          )
      ),
    ),
    button: Colors.white,
      bttext: "NEXT"

  ),


  OnboardModel(
    img: "assets/images/img_3.png",
    text: "Faster claims processing and payment",
    desc: "With real-time processing and updating technology, your claims are guaranteed to be settled within 24 hours",
    bg: Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xff03588C),
              Color(0xff213267),
            ],
          )
      ),
    ),
    button: Colors.white,
      bttext: "GET STARTED"

  ),
];