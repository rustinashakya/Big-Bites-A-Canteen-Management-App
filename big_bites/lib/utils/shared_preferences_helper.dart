import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const String USER_ID_KEY = 'userId';
  static const String USER_DATA_KEY = 'userData';

  Future<void> saveUserId(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(USER_ID_KEY, userId);
  }

  Future<String?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(USER_ID_KEY);
  }

  Future<void> clearUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(USER_ID_KEY);
  }

  Future<void> saveUserData(Map<String, dynamic> userData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userDataJson = json.encode(userData);
    await prefs.setString(USER_DATA_KEY, userDataJson);
  }

  Future<Map<String, dynamic>?> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDataJson = prefs.getString(USER_DATA_KEY);
    if (userDataJson != null) {
      return json.decode(userDataJson) as Map<String, dynamic>;
    }
    return null;
  }

  Future<void> clearUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(USER_DATA_KEY);
  }
}
