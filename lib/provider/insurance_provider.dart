import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jiffy/jiffy.dart';
import '../Backend models/insurance_model.dart';
import '../models/insurance.dart';

class InsuranceProvider extends ChangeNotifier {
  final User? user = FirebaseAuth.instance.currentUser;
  final ImagePicker _imagePicker = ImagePicker();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final List<Insurance> _myInsurance = [];

  bool _isSelected = false;
  File? _carFront;
  File? _carLeft;
  File? _carRight;
  File? _carBack;
  File? _carInterior1;
  File? _carInterior2;
  File? _carInterior3;

  bool get isSelected => _isSelected;
  File? get carFront => _carFront;
  File? get carLeft => _carLeft;
  File? get carRight => _carRight;
  File? get carBack => _carBack;
  File? get carInterior1 => _carInterior1;
  File? get carInterior2 => _carInterior2;
  File? get carInterior3 => _carInterior3;

  List<Insurance> get item => _myInsurance;

  // Insurance findById(int id) =>
  //     _myInsurance.firstWhere((insurance) => insurance.id == id);

  Iterable<Insurance> showSelected() =>
      _myInsurance.where((insurance) => insurance.selected).toList();

  void isSelect() {
    _isSelected = _myInsurance.any((insurance) => insurance.selected);
    notifyListeners();
  }

  pickImage({required ImageSource source, required String which}) async {
    XFile? pickedImage = await _imagePicker.pickImage(source: source);
    if (pickedImage != null) {
      File file = File(pickedImage.path);
      imageFile(which, file);
      notifyListeners();
      log(file.toString());
      // log('...$_interimPoliceReport');
    }
  }

  Future<String?> uploadFile(File? file) async {
    if (file != null) {
      final ref = _firebaseStorage
          .ref()
          .child('New Insurance')
          .child(user!.uid)
          .child(DateTime.now().toString());
      await ref.putFile(file);

      return await ref.getDownloadURL();
    }
    return null;
  }

  imageFile(String which, File imageFile) {
    switch (which) {
      case 'front':
        _carFront = imageFile;
        notifyListeners();
        break;
      case 'left':
        _carLeft = imageFile;
        notifyListeners();
        break;
      case 'right':
        _carRight = imageFile;
        notifyListeners();
        break;
      case 'back':
        _carBack = imageFile;
        notifyListeners();
        break;
      case 'interior1':
        _carInterior1 = imageFile;
        notifyListeners();
        break;
      case 'interior2':
        _carInterior2 = imageFile;
        notifyListeners();
        break;
      case 'interior3':
        _carInterior3 = imageFile;
        notifyListeners();
        break;
    }
  }

  void clearImageFiles() {
    _carFront = null;
    _carBack = null;
    _carRight = null;
    _carLeft = null;
    _carInterior1 = null;
    _carInterior2 = null;
    _carInterior3 = null;
  }

  void getExpiryDate(InsuranceModel model) {
    var yy =
        double.parse(model.policyStartDate.toString().substring(0, 4)).toInt();
    var mm =
        double.parse(model.policyStartDate.toString().substring(6, 7)).toInt();
    var dd =
        double.parse(model.policyStartDate.toString().substring(9, 10)).toInt();

    final startdate = DateTime(yy, mm, dd);
    final period = double.parse(
            model.insurancePeriod.toString().replaceAll(RegExp('[^0-9]'), ''))
        .toInt();

    model.expDate = (Jiffy(startdate).add(months: (period)).dateTime)
        .toString()
        .substring(0, 10);
  }

  void saveNewInsuranceInfoForComprehensive(InsuranceModel model) async {
    getExpiryDate(model);
    model.purchaseId = DateTime.now().millisecondsSinceEpoch.toString();
    model.purchaceDate = DateTime.now().toLocal().toString();
    User? currentUser = FirebaseAuth.instance.currentUser;
    model.userUID = currentUser!.uid;

    await FirebaseFirestore.instance
        .collection("Users")
        .doc(model.userUID)
        .collection("Insurance")
        .doc(model.purchaseId)
        .set({
      "userId": model.userUID,
      "purchaseID": model.purchaseId,
      "policyStartDate": model.policyStartDate,
      "class": model.insuranceClass,
      "type": model.coverType,
      "username": model.username,
      "carMake": model.carmake,
      "carModel": model.carmodel,
      "providerImage": model.providerImage,
      "providerName": model.providerName,
      "vehicleColor": model.vehicleColor,
      "sumInsured": model.sumInsured,
      "regNo": model.registrationNumber,
      "chasisNumber": model.chasisNumber,
      "engineNumber": model.engineNumber,
      "policyPeriod": model.insurancePeriod,
      "purchaseDate": model.purchaceDate,
      "renewalDate": "",
      "premiumPaid": "₦${model.premiumPaid.toString()}",
      "expDate": model.expDate,
      "selectedExtension": model.step3Extensions,
      "additionalThirdParty": model.atp,
      "renewVehicleLicenseData": model.vehicletrackinglicence,
      "carFront": await uploadFile(carFront),
      "carLeft": await uploadFile(carLeft),
      "carRight": await uploadFile(carRight),
      "carBack": await uploadFile(carBack),
      "carInterior1": await uploadFile(carInterior1),
      "carInterior2": await uploadFile(carInterior2),
      "carInterior3": await uploadFile(carInterior3),
    });
  }

  void saveNewInsuranceInfoForThirdParty(InsuranceModel model) async {
    getExpiryDate(model);
    model.purchaseId = DateTime.now().millisecondsSinceEpoch.toString();
    model.purchaceDate = DateTime.now().toLocal().toString();

    model.sumInsured = 0;

    User? currentUser = FirebaseAuth.instance.currentUser;
    model.userUID = currentUser!.uid;

    await FirebaseFirestore.instance
        .collection("Users")
        .doc(model.userUID)
        .collection("New Car Insurance")
        .doc(model.purchaseId)
        .set({
      "userId": model.userUID,
      "purchaseID": model.purchaseId,
      "policyStartDate": model.policyStartDate,
      "class": model.insuranceClass,
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
      "expDate": model.expDate,
      "selected extension": model.step3Extensions,
      "additional third party": model.atp,
      "renew vehicle license data": model.vehicletrackinglicence,
    }).whenComplete(() async {
      await FirebaseFirestore.instance
          .collection("New Car Insurance")
          .doc(model.purchaseId)
          .set({
        "userId": model.userUID,
        "purchaseID": model.purchaseId,
        "policyStartDate": model.policyStartDate,
        "class": model.insuranceClass,
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
        "expDate": model.expDate,
        "selected extension": model.step3Extensions,
        "additional third party": model.atp,
        "renew vehicle license data": model.vehicletrackinglicence,
      });
    });

    notifyListeners();
  }

  List<InsuranceModel> newInsuranceList = [];

  Future<List<Insurance>> getInsuranceData() async {
    // User? user = FirebaseAuth.instance.currentUser;
    final insuranceSnapshot = await firebaseFirestore
        .collection('Users')
        .doc(user!.uid)
        .collection('Insurance')
        .get();
    var insure =  insuranceSnapshot.docs.map(
      (DocumentSnapshot data) => Insurance(
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
      ),
    ).toList();
    // for (var data in insuranceSnapshot.docs) {
    //   Insurance insuranceData = Insurance(
    //     regNum: data.get('regNum') ?? '',
    //     chassisNum: data.get('chasisNumber') ?? '',
    //     engineNum: data.get('engineNumber') ?? '',
    //     id: data.get('purchaseID') ?? '',
    //     class_: data.get('class') ?? '',
    //     type: data.get('type') ?? '',
    //     policy: data.get('providerName'),
    //     policyPeriod: data.get('policyPeriod') ?? '',
    //     provider: data.get('providerName') ?? '',
    //     providerImage: data.get('providerImage') ?? '',
    //     sumInsured: data.get('sumInsured') ?? '',
    //     purchaceDate: data.get('purchaceDate') ?? '',
    //     renewalDate: data.get('renewalDate') ?? '',
    //     premiumPaid: data.get('premiumPaid') ?? '',
    //     expDate: data.get('expDate') ?? '',
    //     carMake: data.get('carMake') ?? '',
    //     carModel: data.get('carModel') ?? '',
    //     carMakeImage: data.get('carMakeImage') ?? '',
    //   );
      // if (!_myInsurance.contains(insuranceData)) {
      //   _myInsurance.add(insuranceData);
      //   log(_myInsurance.length.toString());
    //     notifyListeners();
    //   }
    // }

    return insure;
  }
}
