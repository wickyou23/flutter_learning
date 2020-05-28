import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
// import 'package:shared_preferences/shared_preferences.dart';

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
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
      /// Do something before request is sent
      /// set the token
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // String token = prefs.getString('token');
      // if (token != null) {
      //   options.headers["Authorization"] = "Bearer " + token;
      // }

      print("Pre request:${options.method},${options.baseUrl}${options.path}");
      print("Pre request:${options.headers.toString()}");

      return options; //continue
    }, onResponse: (Response response) async {
      // Do something with response data
      final int statusCode = response.statusCode;
      if (statusCode == 200) {
        if (response.request.path == "login/") {
          // final SharedPreferences prefs = await SharedPreferences.getInstance();

          /// login complete, save the token
          /// response data:
          /// {
          ///   "code": 0,
          ///   "data": Object,
          ///   "msg": "OK"
          ///  }
          final String jsonBody = response.data;
          final JsonDecoder _decoder = new JsonDecoder();
          final resultContainer = _decoder.convert(jsonBody);
          final int code = resultContainer['code'];
          if (code == 0) {
            // final Map results = resultContainer['data'];
            // prefs.setString("token", results["token"]);
            // prefs.setInt("expired", results["expired"]);
          }
        }
      } else if (statusCode == 401) {
        /// token expired, re-login or refresh token
        // final SharedPreferences prefs = await SharedPreferences.getInstance();
        // var username = prefs.getString("username");
        // var password = prefs.getString("password");
        // FormData formData = new FormData.from({
        //   "username": username,
        //   "password": password,
        // });
        // new Dio().post("login/", data: formData).then((resp){
        //   final String jsonBody = response.data;
        //   final JsonDecoder _decoder = new JsonDecoder();
        //   final resultContainer = _decoder.convert(jsonBody);
        //   final int code = resultContainer['code'];
        //   if (code == 0) {
        //     final Map results = resultContainer['data'];
        //     prefs.setString("token", results["token"]);
        //     prefs.setInt("expired", results["expired"]);

        //     RequestOptions ro = response.request;
        //     ro.headers["Authorization"] = "Bearer ${prefs.getString('token')}";
        //     return ro;
        //   } else {
        //     throw Exception("Exception in re-login");
        //   }
        // });
      }

      // print("Response From:${response.request.method},${response.request.baseUrl}${response.request.path}");
      // print("Response From:${response.toString()}");
      return response; // continue
    }, onError: (DioError e) {
      // Do something with response error
      return e; //continue
    }));

    return dio;
  }

  Dio get authDio {
    Dio dio = new Dio();
    // Set default configs
    dio.options.baseUrl = 'https://identitytoolkit.googleapis.com/v1';
    dio.options.connectTimeout = 50000; //5s
    dio.options.receiveTimeout = 30000;
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
      print("Pre request:${options.method},${options.baseUrl}${options.path}");
      print("Pre request:${options.headers.toString()}");
      return options;
    }, onResponse: (Response response) async {
      final int statusCode = response.statusCode;
      if (statusCode == 200) {
        if (response.request.path == "login/") {
          final String jsonBody = response.data;
          final JsonDecoder _decoder = new JsonDecoder();
          final resultContainer = _decoder.convert(jsonBody);
          final int code = resultContainer['code'];
          if (code == 0) {
          }
        }
      } else if (statusCode == 401) {
      }
      return response;
    }, onError: (DioError e) {
      return e;
    }));

    return dio;
  }
}

abstract class ResponseState {
  final int statusCode;

  ResponseState({@required this.statusCode});
}

class ResponseSuccessState<T> extends ResponseState {
  final T responseData;

  ResponseSuccessState({@required int statusCode, @required this.responseData})
      : super(statusCode: statusCode);

  ResponseSuccessState<T> copyWith({int statusCode, T responseData}) {
    return ResponseSuccessState<T>(
      statusCode: statusCode ?? this.statusCode,
      responseData: responseData ?? this.responseData,
    );
  }
}

class ResponseFailedState extends ResponseState {
  final String errorMessage;

  ResponseFailedState({@required int statusCode, @required this.errorMessage})
      : super(statusCode: statusCode);
}
