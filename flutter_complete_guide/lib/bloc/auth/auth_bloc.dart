import 'package:bloc/bloc.dart';
import 'package:flutter_complete_guide/bloc/auth/auth_event.dart';
import 'package:flutter_complete_guide/bloc/auth/auth_state.dart';
import 'package:flutter_complete_guide/data/middleware/authentication_middleware.dart';
import 'package:flutter_complete_guide/data/network_common.dart';
import 'package:flutter_complete_guide/data/repository/auth_repository.dart';
import 'package:flutter_complete_guide/models/auth_user.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repo = AuthRepository();

  @override
  AuthState get initialState => AuthInitializeState();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AuthSignupEvent) {
      yield* _mapToAuthSignupEvent(event);
    } else if (event is AuthSigninEvent) {
      yield* _mapToAuthSigninEvent(event);
    }
  }

  @override
  Future<void> close() {
    print('AuthBloc closed');
    return super.close();
  }

  Stream<AuthState> _mapToAuthSignupEvent(AuthSignupEvent event) async* {
    yield AuthProcessingState();
    ResponseState signupRes = await AuthMiddleware().signup(
      email: event.email,
      password: event.password,
    );

    if (signupRes is ResponseSuccessState<AuthUser>) {
      AuthUser user = signupRes.responseData;
      ResponseState profileRes = await AuthMiddleware().updateProfile(
        user: user,
        name: event.userName,
      );

      if (profileRes is ResponseSuccessState<AuthUser>) {
        user = profileRes.responseData;
      }

      await repo.setCurrentUser(user);
      yield AuthSignupSuccessState();
      yield AuthReadyState(user);
    } else if (signupRes is ResponseFailedState) {
      yield AuthSignupFailedState(failedState: signupRes);
    }
  }

  Stream<AuthState> _mapToAuthSigninEvent(AuthSigninEvent event) async* {
    yield AuthProcessingState();
    ResponseState res = await AuthMiddleware().signin(
      email: event.email,
      password: event.password,
    );

    if (res is ResponseSuccessState<AuthUser>) {
      await repo.setCurrentUser(res.responseData);
      yield AuthSigninSuccessState();
      yield AuthReadyState(res.responseData);
    }
    else if (res is ResponseFailedState) {
      yield AuthSigninFailedState(failedState: res);
    }
  }
}
