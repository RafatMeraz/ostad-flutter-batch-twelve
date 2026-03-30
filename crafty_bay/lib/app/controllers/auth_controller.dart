import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/data/models/user_model.dart';

class AuthController {
  static UserModel? userModel;
  static String? token;

  static const String _tokenKey = 'token';
  static const String _userKey = 'user';

  static Future<void> saveUserData(
    String newToken,
    UserModel newUserData,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, newToken);
    await prefs.setString(_userKey, jsonEncode(newUserData.toJson()));

    token = newToken;
    userModel = newUserData;
  }

  static Future<void> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userModel = UserModel.fromJson(jsonDecode(prefs.getString(_userKey)!));
    token = prefs.getString(_tokenKey);
  }

  static Future<bool> isUserAlreadyLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_tokenKey);
  }

  static Future<void> clearUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_userKey);
    token = null;
    userModel = null;
  }
}
