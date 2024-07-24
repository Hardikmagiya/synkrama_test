import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/model/user_model.dart';

class LocalStorageService {
  static const String userKey = 'user';

  Future<void> saveUser(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(userKey, jsonEncode(user.toJson()));
  }

  Future<UserModel?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString(userKey);
    if (userData != null) {
      final userMap = jsonDecode(userData) as Map<String, dynamic>;
      return UserModel.fromJson(userMap);
    }
    return null;
  }

  Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(userKey);
  }
}
