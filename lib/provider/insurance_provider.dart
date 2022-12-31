import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart' show BuildContext,ChangeNotifier;
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:http/http.dart' as http;

import '../Backend models/insurance_model.dart';
// import '../global/global.dart';
import '../models/insurance.dart';



class InsuranceProvider with ChangeNotifier {

   List<Insurance> _myInsuranceList = list;
  bool _isSelected = false;

  bool get isSelected => _isSelected;


  List<Insurance> get myInsuranceList =>
      [..._myInsuranceList];

  

  // Insurance findById(int id) =>
  //     _myInsurance.firstWhere((insurance) => insurance.id == id);

  Iterable<Insurance> showSelected() =>
      _myInsuranceList.where((insurance) => insurance.selected).toList();

  void isSelect() {
    _isSelected = _myInsuranceList.any((insurance) => insurance.selected);
    notifyListeners();
  }

  void saveNewInsuranceInfo(InsuranceModel model, BuildContext context) async
  {
    model.purchaseId = DateTime
        .now()
        .millisecondsSinceEpoch
        .toString();
    model.purchaceDate = DateTime.now().toLocal().toString();


    User? currentUser = FirebaseAuth.instance.currentUser;
    model.userUID= currentUser!.uid;

    await FirebaseFirestore.instance
        .collection("Users")
        .doc(model.userUID)
        .collection("New Car Insurance")
        .doc(model.purchaseId)
        .set(
        {
          "userId": model.userUID,
          "purchaseID": model.purchaseId,
          "class": "Car Insurance",
          "type": model.coverType,
          "username": model.username,
          "car make": model.carmake,
          "car model": model.carmodel,
          "provider image": model.providerImage,
          "provider name": model.providerName,
          "vehicle color": model.vehicleColor,
          "sum insured": model.sumInsured,
          "reg no": model.registrationNumber,
          "chasis number": model.chasisNumber,
          "engine number": model.engineNumber,
          "policy period": model.insurancePeriod,
          "purchase Date": model.purchaceDate,
          "renewalDate": "",
          "premiumPaid": "₦${model.premiumPaid.toString()}",
          "expDate": "",
          "car year": "",
          "carMakeImage": model.carMakeImage,

        }).whenComplete(() async {
      await FirebaseFirestore.instance
          .collection("New Car Insurance")
          .doc(model.purchaseId)
          .set(
          {
            "userId": model.userUID,
            "purchaseID": model.purchaseId,
            "class": "Car Insurance",
            "type": model.coverType,
            "username": model.username,
            "car make": model.carmake,
            "car model": model.carmodel,
            "provider image": model.providerImage,
            "provider name": model.providerName,
            "vehicle color": model.vehicleColor,
            "sum insured": model.sumInsured,
            "reg no": model.registrationNumber,
            "chasis number": model.chasisNumber,
            "engine number": model.engineNumber,
            "policy period": model.insurancePeriod,
            "purchase Date": model.purchaceDate,
            "renewalDate": "",
            "premiumPaid": "₦${model.premiumPaid.toString()}",
            "expDate": "",
            "car year": "",
            "carMakeImage": model.carMakeImage,

          });

      });

    notifyListeners();

  }

  List<InsuranceModel>newInsuranceList=[];

  Future<void> getNewInsuranceData() async{
    List<InsuranceModel>newList=[];
    User? currentUser = FirebaseAuth.instance.currentUser;
    QuerySnapshot newInsuranceSnapshot= await FirebaseFirestore.instance.collection("Users")
        .doc(currentUser!.uid)
        .collection("New Car Insurance").orderBy("purchase Date",
        descending: true
    )
        .get();
    newInsuranceSnapshot.docs.forEach(
            (element) {
          InsuranceModel insuranceData = InsuranceModel(

              userUID: element["userId"],
              purchaseId: element["purchaseID"],
              insuranceClass: element["class"],
              coverType: element["type"],
              username: element["username"],
              carmake: element["car make"],
              carmodel: element["car model"],
              providerName: element["provider name"],
              providerImage: element["provider image"],
              vehicleColor: element["vehicle color"],
              sumInsured: double.parse((element["sum insured"]).toString()),
              registrationNumber: element["reg no"],
              chasisNumber: element["chasis number"],
              engineNumber: element["engine number"],
              policy:"Joshua Hawkins Car Insurance",
              insurancePeriod: element["policy period"],
              purchaceDate: element["purchase Date"],
              renewalDate: element["renewalDate"],
              premiumPaid: element["premiumPaid"],
              expDate: element["expDate"],
              carYear: element["car year"],
              carMakeImage: element["carMakeImage"],
              step3Extensions: [],


          );
          newList.add(insuranceData);
        });
    // _myInsuranceList=newList;
    notifyListeners();
  }
  

  List<InsuranceModel> selectedRenewList= [];

  List<InsuranceModel> get getSelectedRenewList{
    return selectedRenewList;

  }

  int get getSelectedRenewListLength{
    return selectedRenewList.length;
  }


}



final list = [
  Insurance(
    id: 1,
    class_: 'Car Insurance',
    type: 'Comprehensive',
    policy: 'Joshua Hawkins’s Car Insurance',
    policyPeriod: '1',
    provider: 'Leadway Assurance Plc',
    sumInsured: '₦23,181,700.00',
    purchaceDate: '28-02-2022',
    renewalDate: '28-02-2022',
    premiumPaid: '₦181,700',
    expDate: '28-02-2022',
    carMake: 'Toyota',
    carModel: 'Rav4',
    carYear: 2012,
    regNum: '98765456553',
    chassisNum: '98765456553',
    engineNum: '98765456553',
    carMakeImage: 'assets/images/toyota_logo.png',
    providerImage: 'assets/images/camel.png',
  ),
  Insurance(
    id: 2,
    class_: 'Car Insurance',
    type: 'Comprehensive',
    policy: 'Joshua Hawkins’s Car Insurance',
    policyPeriod: '1',
    provider: 'Leadway Assurance Plc',
    sumInsured: '₦23,181,700.00',
    purchaceDate: '28-02-2022',
    renewalDate: '28-02-2022',
    premiumPaid: '₦181,700',
    expDate: '28-02-2022',
    carMake: 'Toyota',
    carModel: 'Camry',
    carYear: 2012,
    regNum: '98765456553',
    chassisNum: '98765456553',
    engineNum: '98765456553',
    carMakeImage: 'assets/images/toyota_logo.png',
    providerImage: 'assets/images/camel.png',
  ),
  Insurance(
    id: 3,
    class_: 'Car Insurance',
    type: 'Comprehensive',
    policy: 'Joshua Hawkins’s Car Insurance',
    policyPeriod: '1',
    provider: 'Leadway Assurance Plc',
    sumInsured: '₦23,181,700.00',
    purchaceDate: '28-02-2022',
    renewalDate: '28-02-2022',
    premiumPaid: '₦181,700',
    expDate: '28-02-2022',
    carMake: 'Toyota',
    carModel: 'Corola',
    carYear: 2020,
    regNum: '987654565ok',
    chassisNum: '98765456553',
    engineNum: '98765456553',
    carMakeImage: 'assets/images/toyota_logo.png',
    providerImage: 'assets/images/camel.png',
  ),
];

