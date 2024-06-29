import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  LoginCubit() : super(LoginInitial());
  Future<void> Login() async {
    try {
      emit(LoginLoading());
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginFailure(errorMessage: 'No user found for that email.'));
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        emit(LoginFailure(
            errorMessage: 'Wrong password provided for that user.'));
        print('Wrong password provided for that user.');
      }
    }
  }
}
