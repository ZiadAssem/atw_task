import 'package:atw_task/domain/repositories/auth_repo.dart';
import 'package:atw_task/service_locater.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'auth_state.dart';
class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  void signIn(String email, String password) async{
    emit(AuthLoading());
    try {
     final user = await sl<AuthRepo>().signInWithEmailAndPassword(email, password);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
    
  }

  void signUp(String email, String password) async{
    emit(AuthLoading());
    try {
      final user = await sl<AuthRepo>().signUpWithEmailAndPassword(email, password);
      
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }


}