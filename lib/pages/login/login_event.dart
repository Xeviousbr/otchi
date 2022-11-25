part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

@immutable
class TryToLoginEvent extends LoginEvent {
  const TryToLoginEvent(
    this.email,
    this.password,
  );

  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}
