import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterstateapp/login/user_repository.dart';

/*State*/
abstract class AuthenState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthenInitial extends AuthenState {}

class AuthenSuccess extends AuthenState {}

class AuthenFailure extends AuthenState {}

class AuthenInProgress extends AuthenState {}

/*Event*/
abstract class AuthenEvent extends Equatable {
  const AuthenEvent();

  @override
  List<Object> get props => [];
}

class AuthenStarted extends AuthenEvent {}

class AuthenLoggedIn extends AuthenEvent {
  final String token;

  const AuthenLoggedIn({@required this.token});

  @override
  List<Object> get props => [token];

  @override
  String toString() {
    return "AuthenLoggedIn { token: $token}";
  }
}

class AuthenLoggedOut extends AuthenEvent {}

/*bloc*/
class AuthenBloc extends Bloc<AuthenEvent, AuthenState> {
  final UserRepository userRepository;

  AuthenBloc({@required this.userRepository}) : assert(userRepository != null);

  @override
  AuthenState get initialState => AuthenInitial();

  @override
  Stream<AuthenState> mapEventToState(AuthenEvent event) async* {
    if (event is AuthenStarted) {
      final bool hasToken = await userRepository.hasToken();

      if (hasToken) {
        yield AuthenSuccess();
      } else {
        yield AuthenFailure();
      }
    }

    if (event is AuthenLoggedIn) {
      yield AuthenInProgress();
      await userRepository.persitToken(event.token);
      yield AuthenSuccess();
    }

    if (event is AuthenLoggedOut) {
      yield AuthenInProgress();
      await userRepository.deleteToken();
      yield AuthenFailure();
    }
  }
}
