// import 'dart:developer';

// import 'package:cloud_firestore/cloud_firestore.dart';

class InsuranceModel{
  String? userUID;
  String? purchaseId;
  String? policy;
  String? insuranceClass;
  String? providerName;
  String? providerImage;
  String? purchaceDate;
  String? renewalDate;
 String? premiumPaid;
  String? expDate;
  String? carMakeImage;
  String? carYear;
  String? username;
  String? carmake;
  String? carmodel;
  String? coverType;
  String? vehicleColor;
  double sumInsured;
  String? registrationNumber;
  String? chasisNumber;
  String? engineNumber;
  String? insurancePeriod;
  String? atp;
  String? vehicletrackinglicence;
  List<String>step3Extensions;


  InsuranceModel({
    this.userUID,
    this.purchaseId,
    this.insuranceClass,
    this.policy,
    this.providerName,
    this.providerImage,
    this.purchaceDate,
    this.renewalDate,
    this.premiumPaid,
    this.expDate,
    this.carMakeImage,
    this.carYear,
    this.username,
    this.carmake,
    this.carmodel,
    this.coverType,
    this.vehicleColor,
    required this.sumInsured,
    this.registrationNumber,
    this.chasisNumber,
    this.engineNumber,
    this.insurancePeriod,
    required this.step3Extensions,
    this.atp,
    this.vehicletrackinglicence

  });
}

