import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/insurance.dart';

class InsuranceService {
  User? user = FirebaseAuth.instance.currentUser;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Stream<List<Insurance>> get insuranceList {
    var snapshot = firebaseFirestore
        .collection("Users")
        .doc(user!.uid)
        .collection("Insurance")
        .snapshots();
    var insurance = snapshot.map(
      (QuerySnapshot querySnapshot) => querySnapshot.docs.map(
        (DocumentSnapshot data) {
          return Insurance(
            regNum: data.get('regNum') ?? '',
            chassisNum: data.get('chasisNumber') ?? '',
            engineNum: data.get('engineNumber') ?? '',
            id: data.get('purchaseID') ?? '',
            class_: data.get('class') ?? '',
            type: data.get('type') ?? '',
            policy: data.get('providerName'),
            policyPeriod: data.get('policyPeriod') ?? '',
            provider: data.get('providerName') ?? '',
            providerImage: data.get('providerImage') ?? '',
            sumInsured: data.get('sumInsured') ?? '',
            purchaceDate: data.get('purchaceDate') ?? '',
            renewalDate: data.get('renewalDate') ?? '',
            premiumPaid: data.get('premiumPaid') ?? '',
            expDate: data.get('expDate') ?? '',
            carMake: data.get('carMake') ?? '',
            carModel: data.get('carModel') ?? '',
            carMakeImage: data.get('carMakeImage') ?? '',
          );
        },
      ).toList(),
    );
    log(insurance.first.toString());
    return insurance;
  }
}
