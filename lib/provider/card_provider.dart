import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Backend models/cardModel.dart';

class CardProvider with ChangeNotifier {
  User? currentUser = FirebaseAuth.instance.currentUser;

  // UnmodifiableListView<CCard> get cards => UnmodifiableListView(_cards);
  //
  // void addCard(CCard card) {
  //   _cards.add(card);
  //   notifyListeners();
  // }
  //
  // void deleteCard(int index) {
  //   _cards.removeAt(index);
  //   notifyListeners();

  // }

  List<CardModel>cardList=[];

  Future<void> getCardData() async{
    List<CardModel>newList=[];
    QuerySnapshot cardsnapshot= await FirebaseFirestore.instance.collection("Users")
        .doc(currentUser!.uid)
        .collection("Cards")
        .orderBy("uploadedDate", descending: true)
        .get();
    cardsnapshot.docs.forEach(
            (element) {
          CardModel cardData = CardModel(
              userUID : element["userUID"],
              cardID : element["cardID"],
              cardType : element["cardType"],
              cardName : element["cardName"],
              cardNumber: element["cardNumber"],
              cardExp : element["cardExp"],
              cardCVV : element["cardCVV"],
              uploadedDate: element["uploadedDate"],
          );
          newList.add(cardData);
        });
    cardList=newList;
    notifyListeners();
  }
  List<CardModel> get getCardList{
    return cardList;

  }

  int get getCardListLength{
    return cardList.length;
  }

  void deleteCard(int index) async{
    User? currentUser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUser!.uid)
        .collection("Cards")
        .doc(cardList[index].cardID)
        .delete();

    Fluttertoast.showToast(msg: "Card deleted");
    notifyListeners();
  }

  void saveCardInfo(String name,number,exp,cvv) async
  {
    String cardUniqueId = DateTime.now().millisecondsSinceEpoch.toString();
    User? currentUser = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUser!.uid)
        .collection("Cards")
        .doc(cardUniqueId)
        .set(
        {
          "userUID": currentUser.uid,
          "cardID": cardUniqueId,
          "cardType":"",
          "cardName": name,
          "cardNumber":number,
          "cardExp": exp,
          "cardCVV": cvv,
          "uploadedDate": DateTime.now()
        });
    notifyListeners();

  }

// void deleteCartProduct (int index){
  //   cardList.removeAt(index);
  //   notifyListeners();
  // }


}
