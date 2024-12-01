import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/user_model/user_model.dart';

class UserDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> createUser(UserModel user, String? uid) async {
    try {
      final collection = _firestore.collection('users');
      final ref =
          await collection.doc(uid).set(user.toJson()).whenComplete(() {});
      await collection.doc(uid).update({'uid': uid});
    } catch (error) {
      print("Error creating user model");
    }
    return null;
  }
}
