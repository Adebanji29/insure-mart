import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class CardModel
{
  String? userUID;
String? cardID;
 String? cardType;
String? cardName;
 String? cardNumber;
 String? cardExp;
String? cardCVV;
Timestamp? uploadedDate;

CardModel({
   this.userUID,
  this.cardID,
   this.cardType,
   this.cardName,
    this.cardNumber,
    this.cardExp,
     this.cardCVV,
     this.uploadedDate
});
}