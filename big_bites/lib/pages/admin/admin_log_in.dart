import 'dart:math';

import 'package:big_bites/context/app_colors.dart';
import 'package:big_bites/context/my_text_field.dart';
import 'package:big_bites/pages/admin_dashboard_page/admin_dashboard_page.dart';
import 'package:big_bites/pages/common_widget/app_button_widget.dart';
import 'package:big_bites/pages/onboard.dart';
import 'package:big_bites/pages/splash.dart';
import 'package:big_bites/pages/welcome_pcps.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({super.key});

  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  final TextEditingController adminemailController = TextEditingController();
  final TextEditingController adminpasswordController = TextEditingController();
  String email = "", password = "";
  final _formkey = GlobalKey<FormState>();
  bool obscurePassword = true;
  bool isLoading = false;
  IconData iconPassword = CupertinoIcons.eye_fill;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                Image.asset(
                  'assets/images/sign_in/top_surface.png',
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
                const SizedBox(height: 15.0),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: AppColors.yellow,
                              width: 3.0,
                            ),
                          ),
                        ),
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: const Text(
                          'Admin Login',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppColors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30.0),

                      // Email input field
                      MyTextField(
                        controller: adminemailController,
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

                      const SizedBox(height: 15),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: MyTextField(
                          controller: adminpasswordController,
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
                        width: MediaQuery.of(context).size.width * 2,
                        height: 50,
                        borderRadius: 60,
                        color: AppColors.primaryColor,
                        onButtonPressed: isLoading ? null : () => LoginAdmin(),
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
                                'Login',
                                textAlign: TextAlign.center,
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> LoginAdmin() async {
    if (_formkey.currentState?.validate() ?? false) {
      setState(() {
        isLoading = true;
      });

      try {
        final snapshot = await FirebaseFirestore.instance.collection("admin").get();
        
        bool isAdminValid = snapshot.docs.any((result) =>
            result.data()['email'] == adminemailController.text.trim() &&
            result.data()['password'] == adminpasswordController.text.trim());

        if (isAdminValid) {
          if (!mounted) return;
          
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: const Color.fromARGB(255, 109, 226, 59),
            content: Text(
              "Admin Logged In Successfully",
              style: TextStyle(fontSize: 16.0, color: AppColors.black),
            ),
          ));

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => AdminDashboardPage()),
          );
        } 

        
        
        
        else {
          if (!mounted) return;
          
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              "Invalid email or password",
              style: TextStyle(fontSize: 16.0, color: AppColors.white),
            ),
          ));
          adminemailController.clear();
          adminpasswordController.clear();
        }
      } catch (e) {
        if (!mounted) return;
        
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "An error occurred. Please try again.",
            style: TextStyle(fontSize: 16.0, color: AppColors.white),
          ),
        ));
      } finally {
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
      }
    }
  }
}
