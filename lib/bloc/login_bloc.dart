import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:ot/services/auth_error.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LogoutState()) {
    on<SignInEvent>((event, emit) async {
      emit(LogoutState());
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: event.email, password: event.password);
        emit(SignInLoadingState());
      } on FirebaseAuthException catch (e) {
        authErrorLogin = e.toString();
        emit(LogoutState());
      }
    });

    on<LogoutEvent>((event, emit) async {
      emit(LogoutState());
      try {
        await FirebaseAuth.instance.signOut();
        emit(LogoutState());
      } on FirebaseAuthException catch (e) {}
    });

    on<CadastraUserEvent>((event, emit) async {
      emit(LogoutState());
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: event.email, password: event.password);
        emit(LogoutState());
      } on FirebaseAuthException catch (e) {}
    });
  }
}
