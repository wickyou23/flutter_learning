import 'package:flutter/foundation.dart';

class AuthUser {
  final String idToken;
  final String email;
  final String refreshToken;
  final double expiresIn;
  final String localId;

  AuthUser._internal(
    this.idToken,
    this.email,
    this.refreshToken,
    this.expiresIn,
    this.localId,
  );

  factory AuthUser.fromJson({@required Map<String, dynamic> value}) {
    return AuthUser._internal(
      value['idToken'],
      value['email'],
      value['refreshToken'],
      double.parse(value['expiresIn']),
      value['localId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'idToken': this.idToken,
      'email': this.email,
      'refreshToken': this.refreshToken,
      'expiresIn': '${this.expiresIn}',
      'localId': this.localId,
    };
  }
}
