import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_complete_guide/data/middleware/authentication_middleware.dart';
import 'package:flutter_complete_guide/data/network_response_state.dart';
import 'package:flutter_complete_guide/data/repository/auth_repository.dart';
import 'package:flutter_complete_guide/models/auth_user.dart';
import 'package:flutter_complete_guide/services/navigation_service.dart';
import 'package:flutter_complete_guide/wireframe.dart';

class NetworkCommon {
  static final NetworkCommon _singleton = new NetworkCommon._internal();
  static final fbApiKey = 'AIzaSyDYw_z89ZTg1CeWhNxc0wkfntUYR9iBx5s';

  factory NetworkCommon() {
    return _singleton;
  }

  NetworkCommon._internal();

  final JsonDecoder _decoder = new JsonDecoder();

  dynamic decodeResp(d) {
    // ignore: cast_to_non_type
    if (d is Response) {
      final dynamic jsonBody = d.data;
      final statusCode = d.statusCode;

      if (statusCode < 200 || statusCode >= 300 || jsonBody == null) {
        throw new Exception("statusCode: $statusCode");
      }

      if (jsonBody is String) {
        return _decoder.convert(jsonBody);
      } else {
        return jsonBody;
      }
    } else {
      throw d;
    }
  }

  Dio get dio {
    Dio dio = new Dio();
    // Set default configs
    dio.options.baseUrl = 'https://learning-flutter-866e6.firebaseio.com';
    dio.options.connectTimeout = 50000; //5s
    dio.options.receiveTimeout = 30000;
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options) async {
          var user = await AuthRepository().getCurrentUser();
          Map<String, dynamic> preQueryParams = options.queryParameters;
          preQueryParams.update(
            'auth',
            (_) => user.idToken,
            ifAbsent: () => user.idToken,
          );
          options.queryParameters = preQueryParams;

          print("PreReq:${options.method},${options.baseUrl}${options.path}\n");
          print("ReqQueryParam:${options.queryParameters.toString()}\n");
          print("ReqHeader:${options.headers.toString()}\n");

          return options; //continue
        },
        onResponse: (Response response) async {
          print("ResFrom:${response.toString()}");
          return response; // continue
        },
        onError: (DioError e) async {
          // Do something with response error
          var response = e.response;
          if (response.statusCode == 401) {
            var refreshResponse = await AuthMiddleware().refreshToken();
            if (refreshResponse is ResponseSuccessState<AuthUser>) {
              var newUser = refreshResponse.responseData;
              RequestOptions ro = response.request;
              ro.queryParameters.update(
                'auth',
                (value) => newUser.idToken,
                ifAbsent: () => newUser.idToken,
              );

              var tryDio = Dio();
              return await tryDio.request(ro.path, options: ro);
            }
            else {
              AppWireFrame.logout();
              NavigationService().navigateAndReplaceTo('/authentication');
              throw Exception('Exception in re-login');
            }
          }

          return e; //continue
        },
      ),
    );

    return dio;
  }

  Dio get authDio {
    Dio dio = new Dio();
    // Set default configs
    dio.options.baseUrl = 'https://identitytoolkit.googleapis.com/v1';
    dio.options.connectTimeout = 50000; //5s
    dio.options.receiveTimeout = 30000;
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options) async {
          var preQueryParams = options.queryParameters;
          preQueryParams.update(
            'key',
            (_) => NetworkCommon.fbApiKey,
            ifAbsent: () => NetworkCommon.fbApiKey,
          );
          options.queryParameters = preQueryParams;

          print("PreReq:${options.method},${options.baseUrl}${options.path}\n");
          print("ReqQueryParam:${options.queryParameters.toString()}\n");
          print("ReqHeader:${options.headers.toString()}\n");

          return options;
        },
        onResponse: (Response response) async {
          print("ResFrom:${response.toString()}");
          return response;
        },
        onError: (DioError e) {
          return e;
        },
      ),
    );

    return dio;
  }

  Dio get secureTokenDio {
    Dio dio = new Dio();
    // Set default configs
    dio.options.baseUrl = 'https://securetoken.googleapis.com/v1';
    dio.options.connectTimeout = 50000; //5s
    dio.options.receiveTimeout = 30000;
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options) async {
          var preQueryParam = options.queryParameters;
          preQueryParam.update(
            'key',
            (_) => NetworkCommon.fbApiKey,
            ifAbsent: () => NetworkCommon.fbApiKey,
          );
          options.queryParameters = preQueryParam;

          print("PreReq:${options.method},${options.baseUrl}${options.path}\n");
          print("ReqQueryParam:${options.queryParameters.toString()}\n");
          print("ReqHeader:${options.headers.toString()}\n");

          return options;
        },
        onResponse: (Response response) async {
          print("ResFrom:${response.toString()}");
          return response;
        },
        onError: (DioError e) {
          return e;
        },
      ),
    );

    return dio;
  }
}