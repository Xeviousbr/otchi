import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:ot/pages/login/login_bloc.dart';
import 'package:ot/services/auth_service.dart';

part 'logout_state.dart';
part 'logout_event.dart';

class LogoutBlock extends Bloc<LogoutEvent, LogoutState> {
  LogoutBlock() : super(LogoutInitState()) {
    on<TryToLogoutEvent>((event, emit) async {
      emit(LogoutLoadingState());
      try {
        await AuthService.logout();
        emit(LogoutSuceedState());
      } on FirebaseAuthException catch(e) {
        emit(LogoutErrorState(e.toString()));
      }
    });
  }
}