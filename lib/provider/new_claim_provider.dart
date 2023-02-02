import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class NewClaimProvider extends ChangeNotifier {
  final User? user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final ImagePicker _imagePicker = ImagePicker();
  bool _submiting = false;

  final List<String> _regNumList = <String>[];
  String? _regnum;
  File? _swornAvidivit;
  File? _interimPoliceReport;
  File? _finalPoliceReport;
  File? _imageWithRegNum1;
  File? _imageWithRegNum2;
  File? _rdPartyImageWithRegNum1;
  File? _rdPartyImageWithRegNum2;
  File? _additionalImage1;
  File? _additionalImage2;
  File? _additionalImage3;
  File? _rdPartyadditionalImage1;
  File? _rdPartyadditionalImage2;
  File? _rdPartyadditionalImage3;

  List<String> get regNumList => _regNumList;
  bool get submiting => _submiting;
  String? get regNum => _regnum;
  File? get swornAvidivit => _swornAvidivit;
  File? get interimPoliceReport => _interimPoliceReport;
  File? get finalPoliceReport => _finalPoliceReport;
  File? get imageWithRegNum1 => _imageWithRegNum1;
  File? get imageWithRegNum2 => _imageWithRegNum2;
  File? get rdPartyImageWithRegNum1 => _rdPartyImageWithRegNum1;
  File? get rdPartyImageWithRegNum2 => _rdPartyImageWithRegNum2;
  File? get additionalImage1 => _additionalImage1;
  File? get additionalImage2 => _additionalImage2;
  File? get additionalImage3 => _additionalImage3;
  File? get rdPartyadditionalImage1 => _rdPartyadditionalImage1;
  File? get rdPartyadditionalImage2 => _rdPartyadditionalImage2;
  File? get rdPartyadditionalImage3 => _rdPartyadditionalImage3;

  void setRegNum(String val) {
    _regnum = val;
    notifyListeners();
  }

  Future<List<String>> getUserRegNum() async {
    final response = await _firebaseFirestore
        .collection("Users")
        .doc(user!.uid)
        .collection("Insurance")
        .orderBy("purchase Date", descending: true)
        .get();
    // .orderBy("purchase Date", descending: true)
    // .get();
    // response.docs.first;
    for (var element in response.docs) {
      if (!_regNumList.contains(element['reg no'])) {
        _regNumList.add(element['reg no'].toString());
      }

      notifyListeners();
    }
    log(_regNumList.toString());
    return _regNumList;
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
          .child('New Claim')
          .child(user!.uid)
          .child(DateTime.now().toString());
      await ref.putFile(file);

      return await ref.getDownloadURL();
    }
    return null;
  }

  Future<void> submitClaim({
    required String typeOfLoss,
    required String descriptionOfLoss,
    required String descriptionOfDamagedProperty,
    required String dateOfAccident,
    required String estimateOfRepairs,
    required String rdEstimateOfRepairs,
  }) async {
    final String id = const Uuid().v4();
    _submiting = true;
    notifyListeners();
    await _firebaseFirestore
        .collection('Users')
        .doc(user!.uid)
        .collection('New Claim')
        .doc(id)
        .set({
      'id': id,
      'Claim Status': 'more info needed',
      'Claim Amount': '0',
      'Offer Detail': '',
      'Type of Loss': typeOfLoss,
      'Reg Num': regNum,
      'Date of Accident': dateOfAccident,
      'Description of Damaged Property': descriptionOfDamagedProperty,
      'Description of Accident': descriptionOfLoss,
      'Estimate of Repair(own)': estimateOfRepairs,
      'Estimate of Repair(3rd party)': rdEstimateOfRepairs,
      'Sworn Avidivit or Police Report': await uploadFile(swornAvidivit),
      'Interim Police Report(theft)': await uploadFile(interimPoliceReport),
      'Final Police Report(theft)': await uploadFile(finalPoliceReport),
      'Damaged vehicle with reg num 1': await uploadFile(imageWithRegNum1),
      'Damaged vehicle with reg num 2': await uploadFile(imageWithRegNum2),
      '3rd Party Damaged vehicle with reg num 1':
          await uploadFile(rdPartyImageWithRegNum1),
      '3rd Party Damaged vehicle with reg num 2':
          await uploadFile(rdPartyImageWithRegNum2),
      'More Image 1': await uploadFile(additionalImage1),
      'More Image 2': await uploadFile(additionalImage2),
      'More Image 3': await uploadFile(additionalImage3),
      '3rd More Image 1': await uploadFile(rdPartyadditionalImage1),
      '3rd More Image 2': await uploadFile(rdPartyadditionalImage3),
      '3rd More Image 3': await uploadFile(rdPartyadditionalImage1),
    });
    _submiting = false;
    notifyListeners();
  }

  imageFile(String which, File imageFile) {
    switch (which) {
      case 'swpr':
        _swornAvidivit = imageFile;
        notifyListeners();
        break;
      case 'ipr':
        _interimPoliceReport = imageFile;
        notifyListeners();
        break;
      case 'fpr':
        _finalPoliceReport = imageFile;
        notifyListeners();
        break;
      case 'irn1':
        _imageWithRegNum1 = imageFile;
        notifyListeners();
        break;
      case 'irn2':
        _imageWithRegNum2 = imageFile;
        notifyListeners();
        break;
      case '3irn1':
        _rdPartyImageWithRegNum1 = imageFile;
        notifyListeners();
        break;
      case '3irn2':
        _rdPartyImageWithRegNum2 = imageFile;
        notifyListeners();
        break;
      case 'mi1':
        _additionalImage1 = imageFile;
        notifyListeners();
        break;
      case 'mi2':
        _additionalImage2 = imageFile;
        notifyListeners();
        break;
      case 'mi3':
        _additionalImage3 = imageFile;
        notifyListeners();
        break;
      case '3mi1':
        _rdPartyadditionalImage1 = imageFile;
        notifyListeners();
        break;
      case '3mi2':
        _rdPartyadditionalImage2 = imageFile;
        notifyListeners();
        break;
      case '3mi3':
        _rdPartyadditionalImage3 = imageFile;
        notifyListeners();
        break;
    }
  }
}
