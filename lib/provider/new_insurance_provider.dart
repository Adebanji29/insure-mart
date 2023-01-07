import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:flutter/material.dart';

class NewInsuranceTab {
  static const stepOne = 0;
  static const stepTwo = 1;
  static const stepThree = 2;
  static const stepFour = 3;
  static const stepFive = 4;
  static const stepSix = 5;
}

class NewInsuranceManager extends ChangeNotifier {
  final User? user = FirebaseAuth.instance.currentUser;
  int _currentStep = NewInsuranceTab.stepOne;
  final ImagePicker _imagePicker = ImagePicker();
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final List<String> _coverList = const <String>[
    'Comprehensive',
    'Third party only',
  ];
  String? _typeOfCover;
  bool _ebb = false;
  bool _flood = false;
  bool _srcc = false;
  bool _atp = false;
  bool _vtd = false;
  bool _rtd = false;
  final bool _rvl = false;
  bool _rrw = false;
  bool _rhp = false;
  bool _dpe = false;
  final List<String> _selectedExtension = [];
  File? _carFront;
  File? _carLeft;
  File? _carRight;
  File? _carBack;
  File? _carInterior1;
  File? _carInterior2;
  File? _carInterior3;

  List<String> get coverList => _coverList;
  String? get typeOfCover => _typeOfCover;
  bool get ebb => _ebb;
  bool get flood => _flood;
  bool get srcc => _srcc;
  bool get atp => _atp;
  bool get vtd => _vtd;
  bool get rtd => _rtd;
  bool get rvl => _rvl;
  bool get rrw => _rrw;
  bool get rhp => _rhp;
  bool get dpe => _dpe;
  File? get carFront => _carFront;
  File? get carLeft => _carLeft;
  File? get carRight => _carRight;
  File? get carBack => _carBack;
  File? get carInterior1 => _carInterior1;
  File? get carInterior2 => _carInterior2;
  File? get carInterior3 => _carInterior3;

  List<String> get selectedExtension {
    return _selectedExtension;
  }

  int get currentStep => _currentStep;

  void setTypeOfCover(String val) {
    _typeOfCover = val;
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

  void step3Switch(String sel) {
    switch (sel) {
      case 'ebb':
        _ebb = !_ebb;
        if (_ebb & !_selectedExtension.contains('ebb')) {
          _selectedExtension.add('ebb');
        }
        if (!_ebb & _selectedExtension.contains('ebb')) {
          _selectedExtension.remove('ebb');
        }
        notifyListeners();
        break;
      case 'flood':
        _flood = !_flood;
        if (_flood & !_selectedExtension.contains('flood')) {
          _selectedExtension.add('flood');
        }
        if (!_flood & _selectedExtension.contains('flood')) {
          _selectedExtension.remove('flood');
        }
        notifyListeners();
        break;
      case 'srcc':
        _srcc = !_srcc;
        if (_srcc & !_selectedExtension.contains('srcc')) {
          _selectedExtension.add('srcc');
        }
        if (!_srcc & _selectedExtension.contains('srcc')) {
          _selectedExtension.remove('srcc');
        }
        notifyListeners();
        break;
      case 'atp':
        _atp = !_atp;
        if (_atp & !_selectedExtension.contains('atp')) {
          _selectedExtension.add('atp');
        }
        if (!_atp & _selectedExtension.contains('atp')) {
          _selectedExtension.remove('atp');
        }
        log(_selectedExtension.toString());
        notifyListeners();
        break;
      case 'vtd':
        _vtd = !_vtd;
        if (_vtd & !_selectedExtension.contains('vtd')) {
          _selectedExtension.add('vtd');
        }
        if (!_vtd & _selectedExtension.contains('vtd')) {
          _selectedExtension.remove('vtd');
        }
        notifyListeners();
        break;
      case 'rtd':
        _rtd = !_rtd;
        if (_vtd & !_selectedExtension.contains('rtd')) {
          _selectedExtension.add('rtd');
        }
        if (!_vtd & _selectedExtension.contains('rtd')) {
          _selectedExtension.remove('rtd');
        }
        notifyListeners();
        break;
      case 'rrw':
        _rrw = !_rrw;
        if (_rrw & !_selectedExtension.contains('rrw')) {
          _selectedExtension.add('rrw');
        }
        if (!_rrw & _selectedExtension.contains('rrw')) {
          _selectedExtension.remove('rrw');
        }
        notifyListeners();
        break;
      case 'rhp':
        _rhp = !_rhp;
        if (_rhp & !_selectedExtension.contains('rhp')) {
          _selectedExtension.add('rhp');
        }
        if (!_rhp & _selectedExtension.contains('rhp')) {
          _selectedExtension.remove('rhp');
        }
        notifyListeners();
        break;
      case 'dpe':
        _dpe = !_dpe;
        if (_dpe & !_selectedExtension.contains('dpe')) {
          _selectedExtension.add('dpe');
        }
        if (!_dpe & _selectedExtension.contains('dpe')) {
          _selectedExtension.remove('dpe');
        }
        notifyListeners();
        break;
      default:
    }
  }

  void nextStep() {
    if (_currentStep < 5) {
      _currentStep++;
    }
    notifyListeners();
  }

  void previousStep() {
    if (_currentStep > 0) {
      _currentStep--;
    }
    notifyListeners();
  }

  void gotoStep(int step) {
    if (step <= 5 && step >= 0) {
      _currentStep = step;
      notifyListeners();
    }
  }

  String stepTitle() {
    switch (_currentStep) {
      case 0:
        return 'Insurance Details';
      case 1:
        return 'Upload Car Images';
      case 2:
        return 'Choose Extentions';
      case 3:
        return 'Choose Insurance';
      case 4:
        return 'Comfirm Insurance';
      case 5:
        return 'Payment';
      default:
        return '';
    }
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
}

class RetrieveInsuranceManager extends ChangeNotifier {
  int _currentStep = 0;

  int get currentStep => _currentStep;

  void gotoStep(int step) {
    if (step <= 1 && step >= 0) {
      _currentStep = step;
      notifyListeners();
    }
  }
}
