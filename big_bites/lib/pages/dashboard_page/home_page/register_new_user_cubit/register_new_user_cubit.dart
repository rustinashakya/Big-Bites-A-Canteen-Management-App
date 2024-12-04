import 'package:big_bites/model/user_model/user_model.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../services/auth_user_repo.dart';

part 'register_new_user_state.dart';
part 'register_new_user_cubit.freezed.dart';

class RegisterNewUserCubit extends Cubit<RegisterNewUserState> {
  RegisterNewUserCubit(this._auth)
      : super(const RegisterNewUserState.initial());

  final FirebaseAuth _auth;

  Future<void> createAccount(UserModel user, String password) async {
    emit(const RegisterNewUserState.loading());
    try {
      await AuthUserRepo.registerUser(user, password).then((value) {
        emit(const RegisterNewUserState.success());
      }).onError((error, stackTrace) {});
    } catch (e) {
      emit(RegisterNewUserState.error(e.toString()));
    }
  }
}
