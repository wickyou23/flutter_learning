import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_complete_guide/data/network_common.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitializeState extends AuthState {}

// SIGNUP state

class AuthSignupProcessingState extends AuthState {}

class AuthSignupSuccessState extends AuthState {}

class AuthSignupFailedState extends AuthState {
  final ResponseFailedState failedState;

  AuthSignupFailedState({@required this.failedState});

  @override
  List<Object> get props => [failedState];

  @override
  String toString() => 'AuthSignupFailedState { failed: $failedState }';
}

// SIGNIN state

class AuthSigninProcessingState extends AuthState {}

class AuthSigninSuccessState extends AuthState {}

class AuthSigninFailedState extends AuthState {
  final ResponseFailedState failedState;

  AuthSigninFailedState({@required this.failedState});

  @override
  List<Object> get props => [failedState];

  @override
  String toString() => 'AuthSignupFailedState { failed: $failedState }';
}

