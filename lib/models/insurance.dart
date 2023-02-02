import 'package:flutter/foundation.dart' show ChangeNotifier;

class Insurance with ChangeNotifier {
  final String id;
  final String class_;
  final String type;
  final String policy;
  final String policyPeriod;
  final String provider;
  final String providerImage;
  final String sumInsured;
  final String purchaceDate;
  final String renewalDate;
  final String premiumPaid;
  final String expDate;
  final String carMake;
  final String carMakeImage;
  final String carModel;
  final String regNum;
  final String chassisNum;
  final String engineNum;
  bool selected;

  Insurance({
    required this.regNum,
    required this.chassisNum,
    required this.engineNum,
    required this.id,
    required this.class_,
    required this.type,
    required this.policy,
    required this.policyPeriod,
    required this.provider,
    required this.providerImage,
    required this.sumInsured,
    required this.purchaceDate,
    required this.renewalDate,
    required this.premiumPaid,
    required this.expDate,
    required this.carMake,
    required this.carModel,
    required this.carMakeImage,
    this.selected = false,
  });

  toggleSelected() {
    selected = !selected;
    
    notifyListeners();
  }
}
