import 'package:flutter/material.dart';

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