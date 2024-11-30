import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? uid;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? organization;
  final bool? isStaff;
  final String? profilePic;

  UserModel(
      {this.uid,
      this.firstName,
      this.lastName,
      this.email,
      this.organization,
      this.isStaff,
      this.profilePic});

  toJson() {
    return {
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'organization': organization,
      'isStaff': isStaff,
      'profilePic': profilePic,
    };
  }

  factory UserModel.fromDoc(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    return UserModel(
      uid: data?['uid'],
      firstName: data?['firstName'],
      lastName: data?['lastName'],
      email: data?['email'],
      isStaff: data?['isStaff'],
      profilePic: data?['profilePic'],
    );
  }
}
