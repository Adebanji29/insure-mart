// import 'package:flutter/foundation.dart';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../enums/claim_enum.dart';
import '../models/claim_model.dart';
import '../utils/app_theme.dart';

class ClaimProvider extends ChangeNotifier {
  User? user = FirebaseAuth.instance.currentUser;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  final List<Claim> _claims = [];

  List<Claim> get claimList => [..._claims];

  Future<List<Claim>> getClaimsData() async {
    // List<Claim> newList = [];
    final claimSnapshot = await firebaseFirestore
        .collection("Users")
        .doc(user!.uid)
        .collection("New Claim")
        .get();

    // final tt = claimSnapshot.docs.first['']
    // log(claimSnapshot.docs.first.get('Type of Loss'));
    for (var element in claimSnapshot.docs) {
      final pr = element.get("Estimate of Repair(own)").toString().split('₦');
      final rp =
          element.get("Estimate of Repair(3rd party)").toString().split('₦');
      final rr = (pr.length > 1) ? pr[1] : '0';
      final pp = (rp.length > 1) ? rp[1] : '0';

      final rrr = double.parse(rr.replaceAll(',', ''));
      final ppp = double.parse(pp.replaceAll(',', ''));
      final double repairAmount = rrr + ppp;
      log('element');
      log(repairAmount.toString());
      Claim claimData = Claim(
        id: element.get("id").toString().split('-').first,
        status: element.get("Claim Status"),
        assets: "",
        dateOfIncident: element.get("Date of Accident"),
        repairAmount: '₦$repairAmount',
        claimedAmount: '₦${element.get("Claim Amount")}',
        description: element.get('Description of Accident'),
        offerDetail: element.get('Offer Detail'),
        policy: '',
      );

      _claims.add(claimData);
      notifyListeners();
    }
    // _claims = newList;
    notifyListeners();
    return _claims;
  }

  void deleteCard(int index) async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUser!.uid)
        .collection("New Claim")
        .doc(_claims[index].id)
        .delete();

    Fluttertoast.showToast(msg: "Claims deleted");
    notifyListeners();
  }

  Color claimColor(String status) {
    if (status.toLowerCase() == 'under review and adjustment' ||
        status.toLowerCase() == 'claim settled') {
      return InsuremartTheme.green4;
    }
    if (status.toLowerCase() == 'more info needed' ||
        status.toLowerCase() == 'rejected') {
      return InsuremartTheme.red2;
    }
    if (status.toLowerCase() == 'offer recieved') {
      return InsuremartTheme.black4;
    }
    return InsuremartTheme.blue4;
  }

  String claimStatus(ClaimEnum status) {
    switch (status) {
      case ClaimEnum.underReviewAndAdjustment:
        return 'under review and adjustment';
      case ClaimEnum.moreInfoNeeded:
        return 'More Info Needed';
      case ClaimEnum.rejected:
        return 'rejected';
      case ClaimEnum.offerRecieved:
        return 'Offer Recieved';

      default:
        return 'under review and adjustment';
    }
  }

  double claimLevel(String status) {
    switch (status.toLowerCase()) {
      case 'more info needed':
        return .5;
      case 'under review and adjustment':
        return 1;
      case 'offer recieved':
        return 3.7;
      case 'claim settled':
        return 4;
      case 'rejected':
        return 4;
      default:
        return 1;
    }
  }
}
