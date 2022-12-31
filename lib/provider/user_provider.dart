import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../models/user_model.dart';

class  UserProvider with ChangeNotifier {
  List<UserModel>usermodelList = [];

  Future<void> getUserData() async {
    List<UserModel> newList = [];
    User? currentUser = FirebaseAuth.instance.currentUser;
    QuerySnapshot usersnapShot = await FirebaseFirestore.instance.collection(
        "Users")
        .get();
    usersnapShot.docs.forEach(
            (element) {
          if (currentUser?.uid == element.get("uid")) {
            UserModel userModel = UserModel(
              uid: element.get("uid"),
              firstname: element.get("firstname"),
              lastname: element.get("lastname"),
              email: element.get("email"),
              title: element.get("title"),
              gender: element.get("gender"),
              dob: element.get("dob"),
              hAddress: element.get("hAddress"),
              imgUrl: element.get("imgUrl"),
            );
            newList.add(userModel);
          }
        });
    usermodelList = newList;
    notifyListeners();
  }

  List<UserModel> get getUsermodelList {
    return usermodelList;
  }
}