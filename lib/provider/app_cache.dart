import 'package:shared_preferences/shared_preferences.dart';

class AppCache {
  static const kUser = 'user';
  static const kOnboarding = 'onboarding';

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(kUser, false);
  }

  Future<void> completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(kOnboarding, true);
  }

  Future<void> cacheUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(kUser, true);
  }

  Future<bool> isUserLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(kUser) ?? false;
  }

  Future<bool> didCompleteOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(kOnboarding) ?? false;
  }
}
