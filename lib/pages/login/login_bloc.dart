import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:ot/services/auth_service.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitialState()) {
    on<TryToLoginEvent>((event, emit) async {
      emit(LoginLoadingState());
      try {
        await AuthService.login(event.email, event.password);
        emit(LoginSucceedState());
      } on FirebaseAuthException catch (e) {
        emit(LoginErrorState(e.toString()));
      }
    });
  }
}
