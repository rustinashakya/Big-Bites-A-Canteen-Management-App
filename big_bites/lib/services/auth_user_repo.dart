import 'dart:developer';

import 'package:big_bites/model/user_model/user_model.dart';
import 'package:big_bites/services/user_data_source.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AuthUserRepo {
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final UserDataSource _userRepo = UserDataSource();

  static Future<CustomUserModel?> registerUser(
      UserModel user, String password) async {
    try {
      final userCred = await auth.createUserWithEmailAndPassword(
        email: user.email,
        password: password,
      );
      final uid = auth.currentUser?.uid;
      await _userRepo.createUser(user, uid);
      return CustomUserModel(user: userCred.user, uid: uid);
    } on FirebaseAuthException catch (e) {
      String errorMessage = '';
      if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'The account already exists for that email.';
      } else {
        errorMessage = e.message ?? 'An unknown error occurred.';
      }
      print('Error during registration: $errorMessage');
    } catch (e) {
      print('Unexpected error: $e');
    }
    return null;
  }

  static Future<User?> authenticateLogin(String email, String password) async {
    try {
      final userCred = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      final user = userCred.user;
      return user;
    } catch (error) {
      debugPrint('Firebase authentication error: $error');
      throw Exception('Login failed');
    }
  }
}
