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
    }
  }

  @override
  Future<void> close() {
    print('AuthBloc closed');
    return super.close();
  }

  Stream<AuthState> _mapToAuthSignupEvent(AuthSignupEvent event) async* {
    yield AuthSignupProcessingState();
    ResponseState res = await AuthMiddleware().signup(
      email: event.email,
      password: event.password,
    );

    if (res is ResponseSuccessState<AuthUser>) {
      await repo.setCurrentUser(res.responseData);
      yield AuthSigninSuccessState();
    } else if (res is ResponseFailedState) {
      yield AuthSignupFailedState(failedState: res);
    }
  }
}
