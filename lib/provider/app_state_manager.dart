//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/foundation.dart';


// import 'package:flutter/material.dart';

import './app_cache.dart';

class InsuremartTab {
  static const home = 0;
  static const insurance = 1;
  static const claims = 2;
  static const profile = 3;
}

class AppStateManager extends ChangeNotifier {

  // final FirebaseAuth firebase = FirebaseAuth.instance;
  String authErrorMsg = '';
  final _appCache = AppCache();
  bool _onboardingComplete = false;
  int _selectedTab = InsuremartTab.home;

  bool get isOnboardingCmplete => _onboardingComplete;
  int get getSelectedTab => _selectedTab;

  void completeOnboarding() async {
    _onboardingComplete = true;
    await _appCache.completeOnboarding();
    notifyListeners();
  }

  void goToTab(index) {
    _selectedTab = index;
    notifyListeners();
  }


  // Future<void> logout() async {
  //   await AuthService().signOut();
  //   _selectedTab = 0;
  //   await _appCache.logout();
  //
  //   // initializeApp();
  //   notifyListeners();
  // }
}
