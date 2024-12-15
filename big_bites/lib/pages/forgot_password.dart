import 'package:big_bites/context/app_colors.dart';
import 'package:big_bites/context/my_text_field.dart';
import 'package:big_bites/pages/common_widget/app_button_widget.dart';
import 'package:big_bites/pages/sign_up.dart';
import 'package:big_bites/pages/welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController resetemailController = TextEditingController();
  String email = "";
  final _formkey = GlobalKey<FormState>();

  resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        "Password Reset Email has been sent !",
        style: TextStyle(fontSize: 18.0),
      )));
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          "No user found for that email.",
          style: TextStyle(fontSize: 18.0),
        )));
      }
    }
  }

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
              // Top Image
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
                        'Forgot Password',
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
                      controller: resetemailController,
                      hintText: 'Enter Your Email',
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

                    const SizedBox(height: 20),
                    AppButtonWidget(
                      width: MediaQuery.of(context).size.width * 2,
                      height: 50,
                      borderRadius: 60,
                      color: AppColors.primaryColor,
                      onButtonPressed: () {
                        if (_formkey.currentState!.validate()) {
                          setState(() {
                            email = resetemailController.text;
                          });
                          resetPassword();
                        }
                      },
                      child: const Text(
                        'Send Email',
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
                          MaterialPageRoute(
                              builder: (context) => WelcomeUserPage()),
                        );
                      },
                      child: const Text(
                        'Create An Account?',
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
      )),
    );
  }
}
