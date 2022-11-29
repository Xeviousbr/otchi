part of 'logout_bloc.dart';

abstract class LogoutState extends Equatable {}

class LogoutInitState extends Equatable implements LogoutState {
  @override
  List<Object?> get props => [];
}

class LogoutLoadingState extends Equatable implements LogoutState {
  @override
  List<Object?> get props => [];
}

class LogoutSuceedState extends Equatable implements LogoutState {
  @override
  List<Object?> get props => [];
}

class LogoutErrorState extends Equatable implements LogoutState {
  const LogoutErrorState(this.message);
  final String message;

  @override
  List<Object?> get props => [];
}
