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

  final List<Claim> _claims = [
    // Claim(
    //   id: 2452665,
    //   status: 'under review and adjustment',
    //   assets: 'Ford Focus',
    //   dateOfIncident: '28-02-2021',
    //   description:
    //       'Lorem ipsum dolor sit amet, consectetur adipiscing elit. At sed venenatis et vel magna.',
    // ),
    // Claim(
    //   id: 2452637,
    //   status: 'More Info Needed',
    //   assets: 'Ford Focus',
    //   dateOfIncident: '28-02-2021',
    //   description:
    //       'Lorem ipsum dolor sit amet, consectetur adipiscing elit. At sed venenatis et vel magna.',),
    //
    // Claim(
    //   id: 2459539,
    //   status: 'rejected',
    //   assets: 'Toyota Rav4',
    //   dateOfIncident: '28-02-2021',
    //   repairAmount: '₦23,181,700.00',
    //   description:
    //       'Lorem ipsum dolor sit amet, consectetur adipiscing elit. At sed venenatis et vel magna.',
    // ),
    // Claim(
    //   id: 2454539,
    //   status: 'Offer Recieved',
    //   assets: 'Toyota Rav4',
    //   dateOfIncident: '28-02-2021',
    //   repairAmount: '₦23,181,700.00',
    //   claimedAmount: '₦23,181,700.00',
    //   description:
    //       'Lorem ipsum dolor sit amet, consectetur adipiscing elit. At sed venenatis et vel magna.',
    //   offerDetail:
    //       'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque vel pellentesque ullamcorper elit, vitae justo, iaculis. Sed fermentum feugiat dictum risus lorem neque egestas. Faucibus malesuada tortor pulvinar eget. Aliquam cursus neque in lectus eget interdum scelerisque. Molestie ultricies vel libero, proin sem tempus risus, ultricies. Dolor tincidunt dictumst metus pharetra cras in. Morbi ut sed risus nunc a. Amet, amet,',
    // ),
    // Claim(
    //   id: 2454939,
    //   status: 'Claim settled',
    //   assets: 'Toyota Rav4',
    //   dateOfIncident: '28-02-2021',
    //   repairAmount: '₦23,181,700.00',
    //   claimedAmount: '₦23,181,700.00',
    //   description:
    //       'Lorem ipsum dolor sit amet, consectetur adipiscing elit. At sed venenatis et vel magna.',
    //   offerDetail:
    //       'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque vel pellentesque ullamcorper elit, vitae justo, iaculis. Sed fermentum feugiat dictum risus lorem neque egestas. Faucibus malesuada tortor pulvinar eget. Aliquam cursus neque in lectus eget interdum scelerisque. Molestie ultricies vel libero, proin sem tempus risus, ultricies. Dolor tincidunt dictumst metus pharetra cras in. Morbi ut sed risus nunc a. Amet, amet,',
    // ),
  ];

  List<Claim> get claimList => [..._claims];

  Future<void> getClaimsData() async {
    // List<Claim> newList = [];
    final claimSnapshot = await firebaseFirestore
        .collection("Users")
        .doc(user!.uid)
        .collection("New Claim")
        .get();

    // final tt = claimSnapshot.docs.first['']
    // log(claimSnapshot.docs.first.get('Type of Loss'));
    for (var element in claimSnapshot.docs) {
      final repairAmount =
          element.get("Estimate of Repair(own)").toString().split('₦')[0];
      log(repairAmount);
      log('element');
      // // repairAmount.split()
      // // double.parse(element["Estimate of Repair(3rd party)"]);
      // log(repairAmount.toString());
      // Claim claimData = Claim(
      //     // userid: element["userUID"],
      //     id: element["id"],
      //     status: element["Claim Status"],
      //     assets: "",
      //     dateOfIncident: element["Date of Accident"],
      //     repairAmount: element["Estimate of Repair(3rd party)"],
      //     claimedAmount: '₦${element["repair Amount"]}',
      //     description: element["description of accident"],
      //     offerDetail: element["offerDetail"]);
      // _claims.add(claimData);
      // notifyListeners();
    }
    // _claims = newList;
    notifyListeners();
  }

  void deleteCard(int index) async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUser!.uid)
        .collection("claims")
        .doc(_claims[index].id)
        .delete();

    Fluttertoast.showToast(msg: "Card deleted");
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

  saveClaimInfo() async {
    //   showDialog(
    //       context: context,
    //       builder: (context) {
    //         return const Center(child: CircularProgressIndicator());
    //       });
    //   await FirebaseFirestore.instance
    //       .collection("Users")
    //       .doc(currentUser!.uid)
    //       .collection("claims")
    //       .doc(ClaimID)
    //       .set({
    //     // "userUID":currentUser!.uid,
    //     "claimID": ClaimID,
    //     "type of loss": _typeOfLoss.toString(),
    //     "registration Number": _regNum.toString(),
    //     "date Of Incident": _dateOfAccident.text.trim(),
    //     "engineer contact": _mechanicContactNumber.text.trim(),
    //     "repair Amount": _estimateOfrepairs.text.trim(),
    //     "thirdparty repair Amount": _rdestimateOfrepairs.text.trim(),
    //     "description of accident": _descriptionOfAccident.text.trim(),
    //     "description of damaged property":
    //         _descriptionOfDangedProperty.text.trim(),
    //     "police report Image": policereportImg,
    //     "reg number1 image": regnum1img,
    //     "reg number2 image": regnum2Img,
    //     "police report 1": policereport1,
    //     "police report 2": policereport2,
    //     "3rd party reg number 1": partyregnum1img,
    //     "3rd party reg number 2": partyregnum2Img,
    //     "more images 1": moreimages1,
    //     "more images 2": moreimages2,
    //     "more images 3": moreimages3,
    //     "3rd party more images 1": partymoreimages1,
    //     "3rd party more images 2": partymoreimages2,
    //     "3rd party more images 3": partymoreimages3,
    //     "status": 'under review and adjustment',
    //     "assets": 'Car make',
    //     "policy": 'policy',
    //     "claimedAmount": "",
    //     "offerDetail": '',
    //     "publishedDate": DateTime.now().millisecondsSinceEpoch,
    //   });

    //   setState(() {
    //     uploading = false;
    //     ClaimID = DateTime.now().millisecondsSinceEpoch.toString();
    //   });

    //   Navigator.push(context, MaterialPageRoute(builder: (c) => const Main()));
  }
}
