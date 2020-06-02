import 'package:flutter/foundation.dart';

class AuthUser {
  final String idToken;
  final String email;
  final String refreshToken;
  final double expiresIn;
  final String localId;
  final String displayName;

  AuthUser._internal(
    this.idToken,
    this.email,
    this.refreshToken,
    this.expiresIn,
    this.localId,
    this.displayName,
  );

  factory AuthUser.fromJson({@required Map<String, dynamic> value}) {
    return AuthUser._internal(
      value['idToken'],
      value['email'],
      value['refreshToken'],
      double.parse(value['expiresIn']),
      value['localId'],
      value['displayName'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'idToken': this.idToken,
      'email': this.email,
      'refreshToken': this.refreshToken,
      'expiresIn': '${this.expiresIn}',
      'localId': this.localId,
      'displayName': this.displayName,
    };
  }

  AuthUser copyWith({
    String idToken,
    double expiresIn,
    String refreshToken,
    String displayName,
  }) {
    return AuthUser._internal(
      idToken ?? this.idToken,
      this.email,
      refreshToken ?? this.refreshToken,
      expiresIn ?? this.expiresIn,
      this.localId,
      displayName ?? '',
    );
  }
}
