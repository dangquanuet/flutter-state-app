import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterstateapp/login/authen_bloc.dart';
import 'package:flutterstateapp/login/user_repository.dart';

/*State*/
abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginInProgress extends LoginState {}

class LoginFailure extends LoginState {
  final String error;

  const LoginFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() {
    return "LoginFailure { error: $error}";
  }
}

/*Event*/
abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginBUttonPressed extends LoginEvent {
  final String username;
  final String password;

  const LoginBUttonPressed({@required this.username, @required this.password});

  @override
  List<Object> get props => [username, password];

  @override
  String toString() {
    return 'LoginButtonPress { username: $username, password: $password }';
  }
}

/*Bloc*/
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenBloc authenBloc;

  LoginBloc({@required this.userRepository, @required this.authenBloc})
      : assert(userRepository != null),
        assert(authenBloc != null);

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginBUttonPressed) {
      yield LoginInProgress();

      try {
        final token = await userRepository.authenticate(
            username: event.username, password: event.password);
        authenBloc.add(AuthenLoggedIn(token: token));
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
  }
}
