import 'package:big_bites/context/app_colors.dart';
import 'package:big_bites/context/my_text_field.dart';
import 'package:big_bites/pages/common_widget/app_button_widget.dart';
import 'package:big_bites/pages/dashboard_page/dashboard_page.dart';
import 'package:big_bites/pages/forgot_password.dart';
import 'package:big_bites/pages/onboard.dart';
import 'package:big_bites/pages/splash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:big_bites/utils/shared_preferences_helper.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  String email = "", password = "";
  final _formKey = GlobalKey<FormState>();
  bool obscurePassword = true;
  IconData iconPassword = CupertinoIcons.eye_fill;
  bool isLoading = false;

  final TextEditingController useremailController = TextEditingController();
  final TextEditingController userpasswordController = TextEditingController();

  Future<void> userLogin() async {
    setState(() {
      isLoading = true;
    });

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      String userId = userCredential.user?.uid ?? '';

      // Verify user exists in Firestore and get their data
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (!userDoc.exists) {
        throw FirebaseAuthException(
          code: 'user-not-found',
          message: 'User data not found in database.',
        );
      }

      // Get userId from Firestore
      Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
      String firestoreUserId = userData['userId'] ?? '';
      String firstName = userData['First Name'] ?? '';

      if (firestoreUserId.isEmpty) {
        throw FirebaseAuthException(
          code: 'invalid-user',
          message: 'Invalid user data in database.',
        );
      }

      // Save userId to SharedPreferences
      await SharedPreferencesHelper().saveUserId(firestoreUserId);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: const Color.fromARGB(255, 109, 226, 59),
        content: Text(
          "Signed In Successfully",
          style: TextStyle(fontSize: 16.0, color: AppColors.black),
        ),
      ));

      if (context.mounted) {
        Future.delayed(const Duration(milliseconds: 0), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => DashboardPage(
                userId: firestoreUserId,
                firstName: firstName,
              ),
            ),
          );
        });
      }
    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == 'user-not-found') {
        message = "No user found for that email.";
      } else if (e.code == 'wrong-password') {
        message = "Wrong password provided.";
      } else if (e.code == 'invalid-user') {
        message = "Invalid user data in database.";
      } else {
        message = "Invalid Username or Password ";
      }
      _showSnackBar(message, Colors.red);
      useremailController.clear();
      userpasswordController.clear();
    } catch (e) {
      _showSnackBar("An error occurred. Please try again later.", Colors.red);
      useremailController.clear();
      userpasswordController.clear();
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(fontSize: 16, color: Colors.white),
        ),
        backgroundColor: color,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: MyTextField(
                    controller: useremailController,
                    hintText: 'Email',
                    obscureText: false,
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: const Icon(CupertinoIcons.mail_solid),
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Please enter your email.';
                      } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(val)) {
                        return 'Please enter a valid email address.';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: MyTextField(
                    controller: userpasswordController,
                    hintText: 'Password',
                    obscureText: obscurePassword,
                    keyboardType: TextInputType.visiblePassword,
                    prefixIcon: const Icon(CupertinoIcons.lock_fill),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obscurePassword = !obscurePassword;
                          iconPassword = obscurePassword
                              ? CupertinoIcons.eye_fill
                              : CupertinoIcons.eye_slash_fill;
                        });
                      },
                      icon: Icon(iconPassword),
                    ),
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Please enter your password.';
                      } else if (val.length < 6) {
                        return 'Password must be at least 6 characters.';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20),
                AppButtonWidget(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 50,
                  borderRadius: 60,
                  color: AppColors.primaryColor,
                  onButtonPressed: isLoading
                      ? null
                      : () {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              email = useremailController.text.trim();
                              password = userpasswordController.text.trim();
                            });
                            userLogin();
                          }
                        },
                  child: isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: AppColors.black,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text(
                          'Sign In',
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
                const SizedBox(height: 5),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ForgotPassword()),
                    );
                  },
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: AppColors.lightgrey,
                    ),
                  ),
                ),
                const SizedBox(height: 230),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Onboard()),
                    );
                  },
                  child: const Text(
                    'Back to Onboard ?',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: AppColors.lightgrey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
