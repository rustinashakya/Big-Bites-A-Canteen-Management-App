import 'package:big_bites/context/app_colors.dart';
import 'package:big_bites/pages/common_widget/app_button_widget.dart';
import 'package:email_auth/email_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../context/my_text_field.dart';

class CreateAnAccountPage extends StatefulWidget {
  const CreateAnAccountPage({super.key});

  @override
  State<CreateAnAccountPage> createState() => _CreateAnAccountPageState();
}

class _CreateAnAccountPageState extends State<CreateAnAccountPage> {
  final passwordController = TextEditingController();
  final cpasswordController = TextEditingController();
  final emailController = TextEditingController();
  final profilePic = TextEditingController();
  final fnameController = TextEditingController();
  final lnameController = TextEditingController();
  final userTypeController = TextEditingController();
  String userType = "Customer";
  final _formKey = GlobalKey<FormState>();
  IconData iconPassword = CupertinoIcons.eye_fill;
  IconData iconConfirmPassword = CupertinoIcons.eye_fill;
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  bool signUpRequired = false;
  bool passwordsMatch = false;

  bool containsUpperCase = false;
  bool containsLowerCase = false;
  bool containsNumber = false;
  bool containsSpecialChar = false;
  bool contains8Length = false;

  @override
  Widget build(BuildContext context) {
    return 
      // BlocListener<SignUpBloc, SignUpState>(
      // listener: (context, state) {
      //   if (state is SignUpSuccess) {
      //     setState(() {
      //       signUpRequired = false;
      //     });
      //     ScaffoldMessenger.of(context).showSnackBar(
      //       const SnackBar(
      //         content: Text(
      //           'Signed Up Successfully!',
      //           style: TextStyle(color: AppColors.black),
      //         ),
      //         backgroundColor: AppColors.successColor,
      //       ),
      //     );
      //     Future.delayed(const Duration(milliseconds: 1500), () {
      //       Navigator.push(
      //         context,
      //         MaterialPageRoute(builder: (context) => WelcomeToDashboardPage(
      //           fname: fnameController.text, 
      //         )),
      //       );
      //     });
      //   } else if (state is SignUpProcess) {
      //     setState(() {
      //       signUpRequired = true;
      //     });
      //   } else if (state is SignUpFailure) {
      //     setState(() {
      //       signUpRequired = false;
      //     });
      //     ScaffoldMessenger.of(context).showSnackBar(
      //       const SnackBar(
      //         content: Text('Unable to Sign up. Please try again.'),
      //         backgroundColor: Colors.red,
      //       ),
      //     );
      //     emailController.clear();
      //     passwordController.clear();
      //     cpasswordController.clear();
      //     fnameController.clear();
      //     lnameController.clear();
      //     profilePic.clear();
      //   }
      // },
      SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: Column(
                children: [
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Expanded(
                        child: MyTextField(
                          controller: fnameController,
                          hintText: 'First Name',
                          obscureText: false,
                          keyboardType: TextInputType.name,
                          prefixIcon: const Icon(CupertinoIcons.person_fill),
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Please fill in this field';
                            } else if (val.length > 30) {
                              return 'First Name is too long';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 13),
                      Expanded(
                        child: MyTextField(
                          controller: lnameController,
                          hintText: 'Last Name',
                          obscureText: false,
                          keyboardType: TextInputType.name,
                          prefixIcon: const Icon(CupertinoIcons.person_fill),
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Please fill in this field';
                            } else if (val.length > 30) {
                              return 'Last Name is too long';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 13),
                  MyTextField(
                    controller: userTypeController, 
                    hintText: "", 
                    obscureText: false, 
                    keyboardType: TextInputType.text, 
                    prefixIcon: const Icon(CupertinoIcons.person_2_fill),
                    dropdownItems: const [
                      DropdownMenuItem(
                          value: "Customer", child: Text("Customer")),
                      DropdownMenuItem(
                          value: "Canteen Staff", child: Text("Canteen Staff")),
                    ],  
                    onDropdownChanged: (value) {
                      print("Selected user type: $value");
                      userTypeController.text =
                          value ?? ""; 
                    },
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Please select a user type';
                      }
                      if (val != "Customer" && val != "Canteen Staff") {
                        return 'Invalid user type selected';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 13),
                  MyTextField(
                    controller: emailController,
                    hintText: 'Email',
                    obscureText: false,
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: const Icon(CupertinoIcons.mail_solid),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Please fill in this field';
                      } else if (!RegExp(r'^[\w-\.]+@([\w-]+.)+[\w-]{2,4}$')
                          .hasMatch(val)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 13),
                  MyTextField(
                      controller: passwordController,
                      hintText: 'Password',
                      obscureText: obscurePassword,
                      keyboardType: TextInputType.visiblePassword,
                      prefixIcon: const Icon(CupertinoIcons.lock_fill),
                      onChanged: (val) {
                        if (val!.contains(RegExp(r'[A-Z]'))) {
                          setState(() {
                            containsUpperCase = true;
                          });
                        } else {
                          setState(() {
                            containsUpperCase = false;
                          });
                        }
                        if (val.contains(RegExp(r'[a-z]'))) {
                          setState(() {
                            containsLowerCase = true;
                          });
                        } else {
                          setState(() {
                            containsLowerCase = false;
                          });
                        }
                        if (val.contains(RegExp(r'[0-9]'))) {
                          setState(() {
                            containsNumber = true;
                          });
                        } else {
                          setState(() {
                            containsNumber = false;
                          });
                        }
                        if (val.contains(RegExp(
                            r'^(?=.*?[!@#$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^])'))) {
                          setState(() {
                            containsSpecialChar = true;
                          });
                        } else {
                          setState(() {
                            containsSpecialChar = false;
                          });
                        }
                        if (val.length >= 8) {
                          setState(() {
                            contains8Length = true;
                          });
                        } else {
                          setState(() {
                            contains8Length = false;
                          });
                        }
                        return null;
                      },
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            obscurePassword = !obscurePassword;
                            if (obscurePassword) {
                              iconPassword = CupertinoIcons.eye_fill;
                            } else {
                              iconPassword = CupertinoIcons.eye_slash_fill;
                            }
                          });
                        },
                        icon: Icon(iconPassword),
                      ),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Please fill in this field';
                        } else if (!RegExp(
                                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^]).{8,}$')
                            .hasMatch(val)) {
                          return 'Please enter a valid password';
                        }
                        return null;
                      }),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "⚈  1 uppercase",
                            style: TextStyle(
                                color: containsUpperCase
                                    ? Colors.green
                                    : Theme.of(context)
                                        .colorScheme
                                        .onBackground),
                          ),
                          Text(
                            "⚈  1 lowercase",
                            style: TextStyle(
                                color: containsLowerCase
                                    ? Colors.green
                                    : Theme.of(context)
                                        .colorScheme
                                        .onBackground),
                          ),
                          Text(
                            "⚈  1 number",
                            style: TextStyle(
                                color: containsNumber
                                    ? Colors.green
                                    : Theme.of(context)
                                        .colorScheme
                                        .onBackground),
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
                                    : Theme.of(context)
                                        .colorScheme
                                        .onBackground),
                          ),
                          Text(
                            "⚈  8 minimum character",
                            style: TextStyle(
                                color: contains8Length
                                    ? Colors.green
                                    : Theme.of(context)
                                        .colorScheme
                                        .onBackground),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 13),
                  MyTextField(
                    controller: cpasswordController,
                    hintText: 'Confirm Password',
                    obscureText: obscureConfirmPassword,
                    keyboardType: TextInputType.visiblePassword,
                    prefixIcon: const Icon(CupertinoIcons.lock_circle),
                    onChanged: (val) {
                      setState(() {
                        passwordsMatch = val == passwordController.text;
                      });
                    },
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
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Please confirm your password';
                      } else if (val != passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  !signUpRequired
                      ? SizedBox(
                          width: MediaQuery.of(context).size.width * 2,
                          child: AppButtonWidget(
                            height: 50,
                            borderRadius: 60,
                            color: AppColors.primaryColor,
                            onButtonPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // MyUser myUser = MyUser.empty;
                                // myUser.email = emailController.text;
                                // myUser.fname = fnameController.text;
                                // myUser.lname = lnameController.text;
                                // myUser.userType = userTypeController.text;

                                setState(() {
                                  // context.read<SignUpBloc>().add(SignUpRequired(
                                  //     myUser, passwordController.text));
                                });
                              }
                            },
                            child: Text(
                              'Sign Up',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        )
                      : const CircularProgressIndicator(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      );
    // );
  }
}

