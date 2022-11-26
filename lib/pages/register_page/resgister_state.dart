part of 'resgister_bloc.dart';

abstract class RegisterState extends Equatable {}

class RegisterInitialState extends Equatable implements RegisterState {
  @override
  List<Object?> get props => [];
}

class RegisterLoadingState extends Equatable implements RegisterState {
  @override
  List<Object?> get props => [];
}

class RegisterSucceedState extends Equatable implements RegisterState {
  @override
  List<Object?> get props => [];
}

class RegisterErrorState extends Equatable implements RegisterState {
  const RegisterErrorState(this.message);
  final String message;

  @override
  List<Object?> get props => [];
}
