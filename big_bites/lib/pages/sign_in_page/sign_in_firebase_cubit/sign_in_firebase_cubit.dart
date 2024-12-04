import 'package:big_bites/services/auth_user_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_firebase_state.dart';
part 'sign_in_firebase_cubit.freezed.dart';

class SignInFirebaseCubit extends Cubit<SignInFirebaseState> {
  SignInFirebaseCubit() : super(const SignInFirebaseState.initial());

  Future<void> signInAuthentication(String username, String password) async {
    try {
      emit(const SignInFirebaseState.loading());
      final value = await AuthUserRepo.authenticateLogin(username, password);
      emit(SignInFirebaseState.success(value));
    } catch (error, stackTrace) {
      debugPrint('Error during authentication: $error');
      emit(const SignInFirebaseState.error());
    }
  }
}
