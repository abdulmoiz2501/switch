import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/data/models/user_model.dart';

class UserCache {
  static const String userKey = "cached_user";

  Future<void> cacheUser(UserModel user) async {
    print("The user being saved in shared prefs is $user");
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(userKey, jsonEncode(user.toMap()));
  }

  Future<UserModel?> getCachedUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userString = prefs.getString(userKey);
    if (userString != null) {
      print("The user being fetched from shared prefs is $userString");
      final Map<String, dynamic> userMap = jsonDecode(userString);
      return UserModel.fromMap(userMap);
    }
    return null;
  }

  Future<void> clearCachedUser() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(userKey);
  }
}
