import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';



class PushNotificationsSystem
{
  User? currentUser= FirebaseAuth.instance.currentUser;
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  //notifications arrived/received


  //device recognition token
  Future generateDeviceRecognitionToken() async
  {
    String? registrationDeviceToken = await messaging.getToken();

    FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUser!.uid)
        .update(
        {
          "userDeviceToken": registrationDeviceToken,
        });

    messaging.subscribeToTopic("Admin");
    messaging.subscribeToTopic("allUsers");
  }



}