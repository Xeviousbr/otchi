part of 'login_bloc.dart';

abstract class LoginState extends Equatable {}

class LoginInitialState extends Equatable implements LoginState {
  @override
  List<Object?> get props => [];
}

class LoginLoadingState extends Equatable implements LoginState {
  @override
  List<Object?> get props => [];
}

class LoginSucceedState extends Equatable implements LoginState {
  @override
  List<Object?> get props => [];
}

class LoginErrorState extends Equatable implements LoginState {
  const LoginErrorState(this.message);
  final String message;

  @override
  List<Object?> get props => [];
}
