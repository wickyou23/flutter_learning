import 'dart:convert';

import 'package:flutter_complete_guide/models/auth_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

AuthUser _auth;

class AuthRepository {
  Future<AuthUser> getCurrentUser() async {
    if (_auth == null) {
      SharedPreferences sharePre = await SharedPreferences.getInstance();
      String jsonString = sharePre.getString('AuthUser');
      Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      _auth = AuthUser.fromJson(value: jsonMap);
    }

    return _auth;
  }

  Future<void> setCurrentUser(AuthUser crUser) async {
    SharedPreferences sharePre = await SharedPreferences.getInstance();
    var jsonString = jsonEncode(crUser.toMap());
    if (jsonString.isNotEmpty) {
      sharePre.setString('AuthUser', jsonString);
    }
  }
}