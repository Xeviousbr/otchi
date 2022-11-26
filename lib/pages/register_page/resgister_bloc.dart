import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:ot/services/auth_service.dart';

part 'resgister_event.dart';
part 'resgister_state.dart';

class ResgisterBloc extends Bloc<ResgisterEvent, RegisterState> {
  ResgisterBloc() : super(RegisterInitialState()) {
    on<TryToRegisterEvent>((event, emit) async {
      emit(RegisterLoadingState());
      try {
        await AuthService.cadastraUser(event.email, event.password);
        emit(RegisterSucceedState());
      } on FirebaseAuthException catch (e) {
        emit(RegisterErrorState(e.toString()));
      }
    });
  }
}
