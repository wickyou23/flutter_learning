import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_complete_guide/data/network_common.dart';
import 'package:flutter_complete_guide/data/repository/auth_repository.dart';
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
            '/accounts:signUp',
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

  Future<ResponseState> signin(
      {@required String email, @required String password}) async {
    try {
      var body = {
        'email': email,
        'password': password,
        'returnSecureToken': true
      };
      var res = await NetworkCommon().authDio.post(
            '/accounts:signInWithPassword',
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

  Future<ResponseState> updateProfile(
      {@required AuthUser user, @required String name}) async {
    try {
      var body = {
        'idToken': user.idToken,
        'displayName': name,
        'returnSecureToken': true
      };
      var res = await NetworkCommon().authDio.post(
            '/accounts:update',
            data: body,
          );
      var data = res.data as Map<String, dynamic>;
      String userName = data['displayName'] ?? '';
      return ResponseSuccessState(
        statusCode: res.statusCode,
        responseData: user.copyWith(displayName: userName),
      );
    } on DioError catch (e) {
      return ResponseFailedState(
        statusCode: e.response.statusCode,
        errorMessage: e.message,
      );
    }
  }

  Future<ResponseState> refreshToken() async {
    try {
      var authRepo = AuthRepository();
      var user = await authRepo.getCurrentUser();
      var response = await NetworkCommon().secureTokenDio.post(
        '/token',
        data: {
          'grant_type': 'refresh_token',
          'refresh_token': user.refreshToken,
        },
      );
      var data = response.data as Map<String, dynamic> ?? {};
      if (data.isNotEmpty) {
        String newToken = data['id_token'] as String ?? '';
        String newRefreshToken = data['refresh_token'] as String ?? '';
        double newExpiresIn = double.tryParse(data['refresh_token']);
        if (newToken.isNotEmpty && newRefreshToken.isNotEmpty) {
          var copyUser = user.copyWith(
            idToken: newToken,
            refreshToken: newRefreshToken,
            expiresIn: newExpiresIn,
          );
          await authRepo.setCurrentUser(copyUser);
          return ResponseSuccessState(
            statusCode: response.statusCode,
            responseData: copyUser,
          );
        }
      }

      return ResponseFailedState(
        statusCode: response.statusCode,
        errorMessage: 'Token is empty',
      );
    } on DioError catch (e) {
      return ResponseFailedState(
        statusCode: e.response.statusCode,
        errorMessage: e.message,
      );
    }
  }
}
