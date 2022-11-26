part of 'resgister_bloc.dart';

abstract class ResgisterEvent extends Equatable {
  const ResgisterEvent();
}

@immutable
class TryToRegisterEvent extends ResgisterEvent {
  const TryToRegisterEvent(
    this.email,
    this.password,
  );

  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}
