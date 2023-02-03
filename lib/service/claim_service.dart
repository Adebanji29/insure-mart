import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/claim_model.dart';

class ClaimService {
  User? user = FirebaseAuth.instance.currentUser;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Stream<List<Claim>> get claims {
    var snapshot = firebaseFirestore
        .collection("Users")
        .doc(user!.uid)
        .collection("New Claim")
        .snapshots();
    var claims = snapshot.map(
      (QuerySnapshot querySnapshot) => querySnapshot.docs.map(
        (DocumentSnapshot data) {
          final pr = data.get("Estimate of Repair(own)").toString().split('₦');
          final rp =
              data.get("Estimate of Repair(3rd party)").toString().split('₦');
          final rr = (pr.length > 1) ? pr[1] : '0';
          final pp = (rp.length > 1) ? rp[1] : '0';

          final rrr = double.parse(rr.replaceAll(',', ''));
          final ppp = double.parse(pp.replaceAll(',', ''));
          final double repairAmount = rrr + ppp;
          return Claim(
            id: data.get("id").toString().split('-').first,
            status: data.get("Claim Status"),
            assets: "",
            dateOfIncident: data.get("Date of Accident"),
            repairAmount: '₦$repairAmount',
            claimedAmount: '₦${data.get("Claim Amount")}',
            description: data.get('Description of Accident'),
            offerDetail: data.get('Offer Detail'),
            policy: '',
          );
        },
      ).toList(),
    );
    log(claims.first.toString());
    return claims;
  }
}
