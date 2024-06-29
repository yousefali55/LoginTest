import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RegisterCubit() : super(RegisterInitial());
  Future<void> register() async {
    try {
      emit(RegisterLoading());
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterFailure(
            errorMessage: 'The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterFailure(
            errorMessage: 'The account already exists for that email.'));
      }
    } catch (e) {
      emit(RegisterFailure(errorMessage: e.toString()));
    }
  }
}
