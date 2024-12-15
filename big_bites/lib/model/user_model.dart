// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class UserModel {
//   final String? uid;
//   final String firstName;
//   final String lastName;
//   final String email;
//   final String? organization;
//   final String isStaff;
//   final String? profilePic;

//   UserModel(
//       {this.uid,
//       required this.firstName,
//       required this.lastName,
//       required this.email,
//       required this.organization,
//       required this.isStaff,
//       this.profilePic});

//   toJson() {
//     return {
//       'uid': uid,
//       'firstName': firstName,
//       'lastName': lastName,
//       'email': email,
//       'organization': organization,
//       'isStaff': isStaff,
//       'profilePic': profilePic,
//     };
//   }

//   factory UserModel.fromDoc(DocumentSnapshot<Map<String, dynamic>> document) {
//     final data = document.data();
//     return UserModel(
//       uid: data?['uid'],
//       firstName: data?['firstName'] ?? '',
//       lastName: data?['lastName'] ?? '',
//       email: data?['email'] ?? '',
//       isStaff: data?['isStaff'] ?? '',
//       profilePic: data?['profilePic'],
//       organization: data?['organization'] ?? '',
//     );
//   }
// }

// class CustomUserModel {
//   final User? user;
//   final String? uid;

//   const CustomUserModel({
//     this.user,
//     this.uid,
//   });
// }