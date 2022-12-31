import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_model.dart';

class UserService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;
  Map<String, dynamic> loggedInUser = {};
  UserService() {
    // instance();
  }
  // void instance() {
  //   firestore = FirebaseFirestore.instance;
  //   user = FirebaseAuth.instance.currentUser;
  //   loggedInUser;
  // }

  Future<UserModel> getUserDetails() async {
    try {
      firestore.collection('user_details').doc(user!.uid).get().then((value) {
        // final map = value.data() as Map<String, dynamic>;
        // loggedInUser = value.data()!;
        log(loggedInUser['email']);

        return UserModel.fromJson(value.data()!);
      });
    } on Exception catch (e) {
      log('err $e');
    }
    return UserModel();
  }
}
