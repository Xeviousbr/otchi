part of 'login_bloc.dart';

abstract class LoginState extends Equatable {}

class SignInLoadingState extends LoginState {}

class SignInSucceedState implements LoginState {}

class LogoutState extends LoginState {}

class SignInState extends LoginState {}
