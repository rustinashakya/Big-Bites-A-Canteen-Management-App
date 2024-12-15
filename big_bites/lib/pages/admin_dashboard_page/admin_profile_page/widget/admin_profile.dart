import 'package:big_bites/context/app_colors.dart';
import 'package:big_bites/context/my_text_field.dart';
import 'package:big_bites/context/ui_extention.dart';
import 'package:big_bites/pages/common_widget/top_title_widget.dart';
import 'package:big_bites/pages/onboard.dart';
import 'package:big_bites/pages/welcome.dart';
import 'package:big_bites/utils/shared_preferences_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdminProfile extends StatefulWidget {
  const AdminProfile({super.key});

  @override
  State<AdminProfile> createState() => _AdminProfileState();
}

class _AdminProfileState extends State<AdminProfile> {
  final TextEditingController fnameController = TextEditingController();
  final TextEditingController lnameController = TextEditingController();
  final TextEditingController usertypeController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = true;
  bool isEditing = false;
  String? userId;
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    emailController.text = "admin@admin.com";
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final currentUser = _auth.currentUser;
      if (currentUser == null) {
        // _navigateToWelcome();
        return;
      }

      userId = currentUser.uid;
      final adminDoc = await _firestore.collection('admin').doc(userId).get();

      if (adminDoc.exists && mounted) {
        final adminData = adminDoc.data() as Map<String, dynamic>;
        setState(() {
          fnameController.text = adminData['First Name'] ?? '';
          lnameController.text = adminData['Last Name'] ?? '';
          usertypeController.text = 'Admin';
          contactController.text = adminData['Contact'] ?? '';
          emailController.text = adminData['Email'] ?? '';
        });
      }
    } catch (e) {
      print('Error loading admin data: $e');
      if (mounted) {
        _showError('Failed to load profile data');
      }
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  bool _validateFields() {
    if (fnameController.text.trim().isEmpty) {
      _showError('First Name cannot be empty');
      return false;
    }
    if (lnameController.text.trim().isEmpty) {
      _showError('Last Name cannot be empty');
      return false;
    }
    if (contactController.text.trim().isEmpty) {
      _showError('Contact Number cannot be empty');
      return false;
    }
    if (!RegExp(r'^\d{10}$').hasMatch(contactController.text.trim())) {
      _showError('Please enter a valid 10-digit contact number');
      return false;
    }
    if (emailController.text.trim().isEmpty) {
      _showError('Email cannot be empty');
      return false;
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
        .hasMatch(emailController.text.trim())) {
      _showError('Please enter a valid email address');
      return false;
    }
    return true;
  }

  void _showError(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showSuccess(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: AppColors.successColor,
        ),
      );
    }
  }

  Future<void> _updateUserData() async {
    if (!_validateFields()) return;

    setState(() => isLoading = true);

    try {
      final currentUser = _auth.currentUser;
      if (currentUser == null) {
        // _navigateToWelcome();
        return;
      }

      if (currentUser.email != emailController.text.trim()) {
        await currentUser.updateEmail(emailController.text.trim());
      }

      final userData = {
        'First Name': fnameController.text.trim(),
        'Last Name': lnameController.text.trim(),
        'User Type': usertypeController.text,
        'Contact': contactController.text.trim(),
        'Email': emailController.text.trim(),
        'updatedAt': FieldValue.serverTimestamp(),
      };

      await _firestore.collection('users').doc(userId).update(userData);

      setState(() => isEditing = false);
      _showSuccess('Profile updated successfully');
    } on FirebaseAuthException catch (e) {
      String message = 'Failed to update profile';
      if (e.code == 'requires-recent-login') {
        message = 'Please log in again to update your email';
      } else if (e.code == 'email-already-in-use') {
        message = 'This email is already in use by another account';
      }
      _showError(message);
    } catch (e) {
      print('Error updating user data: $e');
      _showError('Failed to update profile. Please try again.');
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }


  Future<void> _logout() async {
    try {
      await _auth.signOut();

      final prefs = SharedPreferencesHelper();
      await prefs.clearUserId();
      await prefs.clearUserData();

    } catch (e) {
      print('Error during logout: $e');
      _showError('Failed to logout. Please try again.');
    }
  }


  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool readOnly = false,
    TextInputType? keyboardType,
    bool isPassword = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
      child: TextFormField(
        controller: controller,
        readOnly: !isEditing || readOnly,
        keyboardType: keyboardType,
        obscureText: isPassword,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black87,
        ),
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          filled: true,
          fillColor: (readOnly) ? Colors.grey[200] : Colors.white,
          enabled: isEditing && !readOnly,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // Center the content vertically
            children: [
              Expanded(
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(children: [
                      SizedBox(
                        height: 20,
                      ),
                      MyTextField(
                        controller: emailController,
                        hintText: 'Email',
                        obscureText: false,
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: const Icon(CupertinoIcons.mail),
                        readOnly: true, 
                      ),
                      20.verticalBox,
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 0),
                      //   child: Column(
                      //     children: [
                      //       Row(
                      //         children: [
                      //           Expanded(
                      //             child: ElevatedButton(
                      //               onPressed: _logout,
                      //               style: ElevatedButton.styleFrom(
                      //                 backgroundColor: Colors.red,
                      //                 padding: const EdgeInsets.symmetric(
                      //                     vertical: 15),
                      //                 shape: RoundedRectangleBorder(
                      //                   borderRadius: BorderRadius.circular(10),
                      //                 ),
                      //               ),
                      //               child: const Text(
                      //                 'Logout',
                      //                 style: TextStyle(
                      //                   color: Colors.white,
                      //                   fontSize: 16,
                      //                   fontWeight: FontWeight.bold,
                      //                 ),
                      //               ),
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //       20.verticalBox,
                      //     ],
                      //   ),
                      // ),
                    ]),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
