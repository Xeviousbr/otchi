part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

@immutable
class LogoutEvent extends LoginEvent {
  const LogoutEvent();
  @override
  List<Object?> get props => throw UnimplementedError();
}

@immutable
class SignInEvent extends LoginEvent {
  final String email;
  final String password;

  const SignInEvent(
    this.email,
    this.password,
  );

  @override
  List<Object?> get props => [email, password];
}

@immutable
class CadastraUserEvent extends LoginEvent {
  final String email;
  final String password;

  const CadastraUserEvent(
    this.email,
    this.password,
  );

  @override
  List<Object?> get props => [email, password];
}
