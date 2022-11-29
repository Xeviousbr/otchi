part of 'logout_bloc.dart';

abstract class LogoutEvent extends Equatable {
  const LogoutEvent();
}

class TryToLogoutEvent extends LogoutEvent {
  const TryToLogoutEvent();
  @override
  List<Object?> get props => [];
}