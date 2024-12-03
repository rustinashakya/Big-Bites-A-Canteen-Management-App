import 'dart:developer';

import 'package:big_bites/context/app_colors.dart';
import 'package:big_bites/context/ui_extention.dart';
import 'package:big_bites/model/user_model/user_model.dart';
import 'package:big_bites/pages/common_widget/app_button_widget.dart';
import 'package:big_bites/pages/dashboard_page/dashboard_page.dart';
import 'package:big_bites/pages/sign_in.dart';
import 'package:big_bites/services/auth_user_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../context/fonts.dart';
import 'dashboard_page/home_page/register_new_user_cubit/register_new_user_cubit.dart';

final _formKey = GlobalKey<FormBuilderState>();

class CreateAnAccountPage extends StatefulWidget {
  const CreateAnAccountPage({super.key});

  @override
  State<CreateAnAccountPage> createState() => _CreateAnAccountPageState();
}

class _CreateAnAccountPageState extends State<CreateAnAccountPage> {
  late RegisterNewUserCubit _newUserCubit;

  @override
  void initState() {
    super.initState();
    _newUserCubit = RegisterNewUserCubit(FirebaseAuth.instance);
  }

  void onSignUpClicked() {
    final user = UserModel(
      email: _formKey.currentState?.fields['email']?.value ?? '',
      firstName: _formKey.currentState?.fields['firstName']?.value ?? '',
      lastName: _formKey.currentState?.fields['lastName']?.value ?? '',
      isStaff: _formKey.currentState?.fields['userType']?.value ?? '',
      organization: _formKey.currentState?.fields['organization']?.value ?? '',
    );
    var password = _formKey.currentState?.fields['email']?.value ?? '';
    log("the user model is here ${user.firstName}");
    _newUserCubit.createAccount(user, password);
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Align(
              alignment: Alignment.topCenter,
              child: Image.asset(
                'assets/images/create_an_account/top_surface.png',
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.20, // Top 35%
              ),
            ),
          ),
          BlocConsumer<RegisterNewUserCubit, RegisterNewUserState>(
            bloc: _newUserCubit,
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
                success: () {
                  Navigator.of(context).pop(); // Dismiss loading dialog
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => DashboardPage()),
                  );
                },
                error: (message) {
                  Navigator.of(context).pop(); // Dismiss loading dialog
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(message)),
                  );
                },
              );
            },
            builder: (context, state) {
              return state.maybeWhen(
                  loading: () => Center(
                        child: CircularProgressIndicator(),
                      ),
                  orElse: () => SingleChildScrollView(
                        child: FormBuilder(
                          key: _formKey,
                          child: Column(
                            children: [
                              // Top Section
                              Container(
                                height: MediaQuery.of(context).size.height *
                                    0.89, // Takes 85% of the screen
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  children: [
                                    40.verticalBox,
                                    Text(
                                      "Sign Up",
                                      style: AppTextStyle.titleLargeInter,
                                    ),
                                    50.verticalBox,
                                    Expanded(
                                      child: Column(
                                        children: [
                                          // Email Field
                                          _buildTextField(
                                              name: 'email', hintText: 'Email'),

                                          const SizedBox(height: 10),

                                          // Name Fields
                                          Row(
                                            children: [
                                              Expanded(
                                                child: _buildTextField(
                                                  name: 'firstName',
                                                  initialValue: 'initial',
                                                  hintText: 'First Name',
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.trim().isEmpty) {
                                                      return 'This field cannot be empty';
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Expanded(
                                                child: _buildTextField(
                                                  name: 'lastName',
                                                  hintText: 'Last Name',
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.trim().isEmpty) {
                                                      return 'This field cannot be empty';
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),

                                          const SizedBox(height: 10),

                                          // User Type Dropdown
                                          _buildDropdown(
                                            name: 'userType',
                                            hintText: 'User Type',
                                            items: const [
                                              DropdownMenuItem(
                                                  value: 'Staff',
                                                  child: Text('Staff')),
                                              DropdownMenuItem(
                                                  value: 'Customer',
                                                  child: Text('Customer')),
                                            ],
                                          ),

                                          const SizedBox(height: 10),

                                          // Organization Dropdown
                                          _buildDropdown(
                                            name: 'organization',
                                            hintText: 'Organization',
                                            items: const [
                                              DropdownMenuItem(
                                                  value: 'Company A',
                                                  child: Text('Company A')),
                                              DropdownMenuItem(
                                                  value: 'Company B',
                                                  child: Text('Company B')),
                                            ],
                                          ),

                                          const SizedBox(height: 10),

                                          // Password Fields
                                          _buildTextField(
                                            name: 'password',
                                            hintText: 'Password',
                                            isObscure: true,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.trim().isEmpty) {
                                                return 'Password cannot be empty';
                                              }
                                              if (value.length < 6) {
                                                return 'Password must be at least 6 characters';
                                              }
                                              return null;
                                            },
                                          ),
                                          const SizedBox(height: 10),
                                          _buildTextField(
                                            name: 'confirmPassword',
                                            hintText: 'Confirm Password',
                                            isObscure: true,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.trim().isEmpty) {
                                                return 'Password cannot be empty';
                                              }
                                              if (value.length < 6) {
                                                return 'Password must be at least 6 characters';
                                              }
                                              return null;
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    AppButtonWidget(
                                      onButtonPressed: onSignUpClicked,
                                      borderRadius: 50,
                                      child: Text(
                                        "Create Account",
                                        style: AppTextStyle.labelMediumInter,
                                      ),
                                      width: double.infinity,
                                      height: 50,
                                    )
                                  ],
                                ),
                              ),

                              // Footer Section
                              Container(
                                height: MediaQuery.of(context).size.height *
                                    0.15, // Takes 15% of the screen
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Already have an Account?",
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
                                            builder: (context) =>
                                                const SignInPage(),
                                          ),
                                        );
                                      },
                                      child: const Text(
                                        'Sign In',
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
                              ),
                            ],
                          ),
                        ),
                      ));
            },
          )
        ],
      ),
    );
  }

  Widget _buildTextField(
      {required String name,
      required String hintText,
      String? initialValue,
      bool isObscure = false,
      String? Function(String?)? validator}) {
    return FormBuilderTextField(
      name: name,
      validator: validator,
      initialValue: initialValue,
      obscureText: isObscure,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFF5F5F5),
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Color(0xFFD9D9D9),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Color(0xFFD9D9D9),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String name,
    required String hintText,
    required List<DropdownMenuItem> items,
  }) {
    return FormBuilderDropdown(
      name: name,
      items: items,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFF5F5F5),
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Color(0xFFD9D9D9),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Color(0xFFD9D9D9),
          ),
        ),
      ),
    );
  }
}
