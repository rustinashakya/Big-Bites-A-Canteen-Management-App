import 'package:big_bites/model/user_model/user_model.dart';
import 'package:big_bites/services/user_data_source.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthUserRepo {
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final UserDataSource _userRepo = UserDataSource();

  static Future<UserModel?> registerUser(
      UserModel user, String password) async {
    try {
      final userCred = await auth.createUserWithEmailAndPassword(
        email: user.email!,
        password: password,
      );
      final uid = auth.currentUser?.uid;
      await _userRepo.createUser(user, uid);
      return UserModel(uid: uid);
    } catch (e) {
      if (kDebugMode) {
        print('Error while registering: $e');
      }
      rethrow;
    }
  }
}
