import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_complete_guide/data/network_common.dart';
import 'package:flutter_complete_guide/models/auth_user.dart';

class AuthMiddleware {
  static final AuthMiddleware _singleton = AuthMiddleware._internal();

  factory AuthMiddleware() {
    return _singleton;
  }

  AuthMiddleware._internal();

  Future<ResponseState> signup(
      {@required String email, @required String password}) async {
    try {
      var body = {
        'email': email,
        'password': password,
        'returnSecureToken': true
      };
      var res = await NetworkCommon().authDio.post(
            '/accounts:signUp?key=${NetworkCommon.fbApiKey}',
            data: body,
          );
      var data = res.data as Map<String, dynamic>;
      return ResponseSuccessState(
        statusCode: res.statusCode,
        responseData: AuthUser.fromJson(value: data),
      );
    } on DioError catch (e) {
      return ResponseFailedState(
        statusCode: e.response.statusCode,
        errorMessage: e.message,
      );
    }
  }
}
