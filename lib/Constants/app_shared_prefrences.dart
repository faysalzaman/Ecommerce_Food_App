import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreferences {
  // Shared Preferences Keys
  static const String token = "token";
  static const String userId = "userId";

  // Shared Preferences Instance
  static SharedPreferences? _prefs;

  // Initialize Shared Preferences
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Getters
  static String? get getToken => _prefs?.getString(token);
  static String? get getUserId => _prefs?.getString(userId);

  // Setters
  static Future<void> setToken(String token) async {
    await _prefs?.setString(AppSharedPreferences.token, token);
  }

  static Future<void> setUserId(String userId) async {
    await _prefs?.setString(AppSharedPreferences.userId, userId);
  }
}
