import 'dart:io';

import 'package:big_bites/context/app_colors.dart';
import 'package:big_bites/context/fonts.dart';
import 'package:big_bites/context/my_text_field.dart';
import 'package:big_bites/pages/common_widget/app_button_widget.dart';
import 'package:big_bites/pages/dashboard_page/dashboard_page.dart';
import 'package:big_bites/pages/log_in.dart';
import 'package:big_bites/pages/welcome.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String fname = "", lname = "", usertype = "", email = "", password = "", contact = "";
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cpasswordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usertypeController = TextEditingController();
  final TextEditingController fnameController = TextEditingController();
  final TextEditingController lnameController = TextEditingController();
  final TextEditingController contactController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  IconData iconPassword = CupertinoIcons.eye_fill;
  IconData iconConfirmPassword = CupertinoIcons.eye_fill;
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  bool containsUpperCase = false;
  bool containsLowerCase = false;
  bool containsNumber = false;
  bool containsSpecialChar = false;
  bool contains8Length = false;

  bool isLoading = false;

  Future<void> registration() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      // Check for internet connectivity
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isEmpty || result[0].rawAddress.isEmpty) {
          throw Exception('No internet connection');
        }
      } catch (_) {
        throw Exception('No internet connection');
      }

      // Create auth user
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      
      String userId = userCredential.user?.uid ?? '';

      // Create Firestore document
      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        "userId": userId,
        "First Name": fnameController.text.trim(),
        "Last Name": lnameController.text.trim(),
        "User Type": usertypeController.text.trim(),
        "Email": emailController.text.trim(),
        "Password": passwordController.text,
        "Contact": contactController.text.trim(),
        "createdAt": FieldValue.serverTimestamp(),
      });

      await userCredential.user?.updateDisplayName('${fnameController.text} ${lnameController.text}');

      if (!mounted) return;

      showSnackBar("Registration successful! Please sign in.", const Color.fromARGB(255, 109, 226, 59));

      // Clear fields
      fnameController.clear();
      lnameController.clear();
      usertypeController.clear();
      emailController.clear();
      passwordController.clear();
      cpasswordController.clear();
      contactController.clear();

      // Add delay before navigation
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const WelcomeUserPage()),
          );
        }
      });
    } on FirebaseException catch (e) {
      String errorMessage = 'An error occurred during registration';
      if (e.code == 'weak-password') {
        errorMessage = "Password is too weak. Please use a stronger password.";
      } else if (e.code == "email-already-in-use") {
        errorMessage = "An account already exists with this email.";
      } else if (e.code == "invalid-email") {
        errorMessage = "Please enter a valid email address.";
      }
      showSnackBar(errorMessage, Colors.red);
    } catch (e) {
      if (e.toString().contains('No internet connection')) {
        showSnackBar("No internet connection. Please check your network.", Colors.orange);
      } else {
        showSnackBar("An unexpected error occurred. Please try again.", Colors.red);
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  void showSnackBar(String message, Color backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: backgroundColor,
      content: Text(
        message,
        style: TextStyle(fontSize: 16.0),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: MyTextField(
                          controller: fnameController,
                          hintText: 'First Name',
                          obscureText: false,
                          keyboardType: TextInputType.name,
                          prefixIcon: const Icon(CupertinoIcons.person_fill),
                          validator: (val) => val!.isEmpty
                              ? 'Please fill in this field'
                              : val.length > 30
                                  ? 'First Name is too long'
                                  : null,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: MyTextField(
                          controller: lnameController,
                          hintText: 'Last Name',
                          obscureText: false,
                          keyboardType: TextInputType.name,
                          prefixIcon: const Icon(CupertinoIcons.person_fill),
                          validator: (val) => val!.isEmpty
                              ? 'Please fill in this field'
                              : val.length > 30
                                  ? 'Last Name is too long'
                                  : null,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  MyTextField(
                    controller: usertypeController,
                    hintText: "",
                    obscureText: false,
                    keyboardType: TextInputType.text,
                    prefixIcon: const Icon(CupertinoIcons.person_2_fill),
                    dropdownItems: const [
                      DropdownMenuItem(
                          value: "Customer", child: Text("Customer")),
                      // DropdownMenuItem(
                      //     value: "Canteen Staff", child: Text("Canteen Staff")),
                    ],
                    onDropdownChanged: (value) {
                      print("Selected user type: $value");
                      usertypeController.text = value ?? "";
                    },
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Please select a user type';
                      }
                      // if (val != "Customer" && val != "Canteen Staff") {
                      //   return 'Invalid user type selected';
                      // }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: MyTextField(
                      controller: contactController,
                      hintText: 'Contact Number',
                      obscureText: false,
                      keyboardType: TextInputType.phone,
                      prefixIcon: const Icon(CupertinoIcons.phone_fill),
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Please enter your contact number.';
                        } else if (!RegExp(r'^\d{10}$').hasMatch(val)) {
                          return 'Please enter a valid 10-digit contact number.';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  MyTextField(
                    controller: emailController,
                    hintText: 'Email',
                    obscureText: false,
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: const Icon(CupertinoIcons.mail_solid),
                    validator: (val) => val!.isEmpty
                        ? 'Please fill in this field'
                        : !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                .hasMatch(val)
                            ? 'Please enter a valid email'
                            : null,
                  ),
                  const SizedBox(height: 16),
                  MyTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: obscurePassword,
                    keyboardType: TextInputType.visiblePassword,
                    prefixIcon: const Icon(CupertinoIcons.lock_fill),
                    onChanged: (val) {
                      setState(() {
                        containsUpperCase = RegExp(r'[A-Z]').hasMatch(val);
                        containsLowerCase = RegExp(r'[a-z]').hasMatch(val);
                        containsNumber = RegExp(r'\d').hasMatch(val);
                        containsSpecialChar =
                            RegExp(r'[!@#\$&*~]').hasMatch(val);
                        contains8Length = val.length >= 8;
                      });
                    },
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
                    validator: (val) => val!.isEmpty
                        ? 'Please fill in this field'
                        : !RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#\$&*~]).{8,}$')
                                .hasMatch(val)
                            ? 'Password must include uppercase, lowercase, number, and special character'
                            : null,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "⚈  1 uppercase",
                            style: TextStyle(
                              color: containsUpperCase
                                  ? Colors.green
                                  : Colors.black,
                            ),
                          ),
                          Text(
                            "⚈  1 lowercase",
                            style: TextStyle(
                              color: containsLowerCase
                                  ? Colors.green
                                  : Colors.black,
                            ),
                          ),
                          Text(
                            "⚈  1 number",
                            style: TextStyle(
                              color:
                                  containsNumber ? Colors.green : Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "⚈  1 special character",
                            style: TextStyle(
                              color: containsSpecialChar
                                  ? Colors.green
                                  : Colors.black,
                            ),
                          ),
                          Text(
                            "⚈  8 minimum characters",
                            style: TextStyle(
                              color:
                                  contains8Length ? Colors.green : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  MyTextField(
                    controller: cpasswordController,
                    hintText: 'Confirm Password',
                    obscureText: obscureConfirmPassword,
                    keyboardType: TextInputType.visiblePassword,
                    prefixIcon: const Icon(CupertinoIcons.lock_circle),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obscureConfirmPassword = !obscureConfirmPassword;
                          iconConfirmPassword = obscureConfirmPassword
                              ? CupertinoIcons.eye_fill
                              : CupertinoIcons.eye_slash_fill;
                        });
                      },
                      icon: Icon(iconConfirmPassword),
                    ),
                    validator: (val) => val!.isEmpty
                        ? 'Please confirm your password'
                        : val != passwordController.text
                            ? 'Passwords do not match'
                            : null,
                  ),
                  const SizedBox(height: 20),
                  AppButtonWidget(
                    width: MediaQuery.of(context).size.width * 2,
                    height: 50,
                    borderRadius: 60,
                    color: AppColors.primaryColor,
                    onButtonPressed: isLoading ? null : () {
                      setState(() {
                        fname = fnameController.text;
                        lname = lnameController.text;
                        usertype = usertypeController.text;
                        email = emailController.text;
                        password = passwordController.text;
                        contact = contactController.text;
                      });
                      registration();
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
                            'Sign Up',
                            style: TextStyle(
                              color: AppColors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
