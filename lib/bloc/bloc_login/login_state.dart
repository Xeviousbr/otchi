part of 'login_bloc.dart';

abstract class LoginState extends Equatable {}

class SignInLoadingState extends LoginState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class SignInSuccessdState implements LoginState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  @override
  // TODO: implement stringify
  bool? get stringify => throw UnimplementedError();
}

class LogoutState extends LoginState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class SignInState extends LoginState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
