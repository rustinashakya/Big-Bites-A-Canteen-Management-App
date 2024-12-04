import 'dart:developer';

import 'package:big_bites/context/app_colors.dart';
import 'package:big_bites/context/app_text_form_field.dart';
import 'package:big_bites/context/fonts.dart';
import 'package:big_bites/context/ui_extention.dart';
import 'package:big_bites/pages/create_an_account.dart';
import 'package:big_bites/pages/dashboard_page/dashboard_page.dart';
import 'package:big_bites/pages/sign_in_page/sign_in_firebase_cubit/sign_in_firebase_cubit.dart';
import 'package:big_bites/pages/welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

final _formKey = GlobalKey<FormBuilderState>();

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late SignInFirebaseCubit _signInFirebaseCubit;

  @override
  void initState() {
    super.initState();
    _signInFirebaseCubit = SignInFirebaseCubit();
  }

  _onSignInButtonClicked() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      String username = _formKey.currentState?.fields['email']!.value;
      username = username.trim();
      String password = _formKey.currentState?.fields['password']!.value;
      password = password.trim();
      _signInFirebaseCubit.signInAuthentication(
        username,
        password,
      );
    } else {
      // Optional: Display validation error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFFFFFFF),
      body: BlocListener<SignInFirebaseCubit, SignInFirebaseState>(
        bloc: _signInFirebaseCubit,
        listener: (context, state) {
          state.when(
              initial: () {},
              loading: () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) =>
                      const Center(child: CircularProgressIndicator()),
                );
              },
              success: (_) {
                Navigator.pop(context);
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DashboardPage()),
                    (route) => false);
              },
              error: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Invalid username and password')),
                );
              });
        },
        child: Stack(
          children: [
            // Top Surface Image
            Positioned(
              top: deviceHeight * 0.0,
              left: 0,
              right: 0,
              child: SizedBox(
                width: double.infinity,
                height: deviceHeight * 0.2,
                child: Image.asset(
                  'assets/images/sign_in/top_surface.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // User Image
            FormBuilder(
              key: _formKey,
              child: Column(
                children: [
                  Expanded(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 130,
                              height: 130,
                              child: Image.asset(
                                'assets/images/sign_in/user_image.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                            Text(
                              'Welcome Back!',
                              style: AppTextStyle.labelLargeInter.copyWith(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 32,
                                  color: AppColors.yellow),
                            ),
                            Text('Sign In',
                                style: AppTextStyle.labelLargeInter.copyWith(
                                    fontWeight: FontWeight.w600, fontSize: 28)),
                            10.verticalBox,
                            AppTextFormField(
                              name: 'email',
                              hint: 'Enter your email',
                            ),
                            10.verticalBox,
                            AppTextFormField(
                              name: 'password',
                              hint: 'Enter your password',
                              suffixIcon: Icon(Icons.remove_red_eye),
                              suffixIconColor: AppColors.grey.withOpacity(0.3),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    // Add functionality
                                  },
                                  child: const Text(
                                    'Forgot Password?',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      color: Color(0xFF5F5F5F),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            20.verticalBox,
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFF1B136),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                  side: BorderSide(
                                    color: Colors.black.withOpacity(0.25),
                                    width: 1.0,
                                  ),
                                ),
                                minimumSize: const Size(
                                    double.infinity, 50), // Full-width button
                              ),
                              onPressed: _onSignInButtonClicked,
                              child: Text(
                                'Sign In',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an Account?",
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Color(0xFF5F5F5F),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateAnAccountPage()),
                          );
                        },
                        child: const Text(
                          'Create One',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Color(0xFFF1B136),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Forgot Password

            // Donot Have An Account Section
          ],
        ),
      ),
    );
  }
}
