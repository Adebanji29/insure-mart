import 'package:flutter/foundation.dart';

class NotificationProvider extends ChangeNotifier {
  bool _allNotifications = false;
  bool _newsNotification = false;
  bool _insuranceNotification = true;

  bool get all => _allNotifications;
  bool get news => _newsNotification;
  bool get insurance => _insuranceNotification;

  void changeAll() {
    _allNotifications = !_allNotifications;
    if (_allNotifications & !_newsNotification) {
      _newsNotification = true;
    }
    if (_allNotifications & !_insuranceNotification) {
      _insuranceNotification = true;
    }
    notifyListeners();
  }

  void changeNews() {
    _newsNotification = !_newsNotification;
    if (!_newsNotification & _allNotifications) {
      _allNotifications = false;
    }
    customSettings();
    notifyListeners();
  }

  void changeInsurance() {
    _insuranceNotification = !_insuranceNotification;
    if (!_insuranceNotification & _allNotifications) {
      _allNotifications = false;
    }
    customSettings();
    notifyListeners();
  }

  void customSettings() {
    if (_newsNotification & _insuranceNotification) {
      _allNotifications = true;
    }
    notifyListeners();
  }
}
