import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthSignupEvent extends AuthEvent {
  final String userName;
  final String email;
  final String password;

  AuthSignupEvent({
    @required this.email,
    @required this.password,
    @required this.userName,
  });

  @override
  List<Object> get props => [email, password, userName];
}

class AuthSigninEvent extends AuthEvent {
  final String email;
  final String password;

  AuthSigninEvent({
    @required this.email,
    @required this.password,
  });

  @override
  List<Object> get props => [email, password];
}
