import 'package:big_bites/pages/create_an_account/bloc/create_an_account_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';
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
  final emailController = TextEditingController();
	final nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
	IconData iconPassword = CupertinoIcons.eye_fill;
	bool obscurePassword = true;
	bool signUpRequired = false;

	bool containsUpperCase = false;
	bool containsLowerCase = false;
	bool containsNumber = false;
	bool containsSpecialChar = false;
	bool contains8Length = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
			listener: (context, state) {
				if(state is SignUpSuccess) {
					setState(() {
					  signUpRequired = false;
					});
				} else if(state is SignUpProcess) {
					setState(() {
					  signUpRequired = true;
					});
				} else if(state is SignUpFailure) {
					return;
				} 
			},
			child: Form(
        key: _formKey,
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const Icon(CupertinoIcons.mail_solid),
                  validator: (val) {
                    if(val!.isEmpty) {
                      return 'Please fill in this field';													
                    } else if(!RegExp(r'^[\w-\.]+@([\w-]+.)+[\w-]{2,4}$').hasMatch(val)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  }
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: obscurePassword,
                  keyboardType: TextInputType.visiblePassword,
                  prefixIcon: const Icon(CupertinoIcons.lock_fill),
                  onChanged: (val) {
                    if(val!.contains(RegExp(r'[A-Z]'))) {
                      setState(() {
                        containsUpperCase = true;
                      });
                    } else {
                      setState(() {
                        containsUpperCase = false;
                      });
                    }
                    if(val.contains(RegExp(r'[a-z]'))) {
                      setState(() {
                        containsLowerCase = true;
                      });
                    } else {
                      setState(() {
                        containsLowerCase = false;
                      });
                    }
                    if(val.contains(RegExp(r'[0-9]'))) {
                      setState(() {
                        containsNumber = true;
                      });
                    } else {
                      setState(() {
                        containsNumber = false;
                      });
                    }
                    if(val.contains(RegExp(r'^(?=.*?[!@#$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^])'))) {
                      setState(() {
                        containsSpecialChar = true;
                      });
                    } else {
                      setState(() {
                        containsSpecialChar = false;
                      });
                    }
                    if(val.length >= 8) {
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
                        if(obscurePassword) {
                          iconPassword = CupertinoIcons.eye_fill;
                        } else {
                          iconPassword = CupertinoIcons.eye_slash_fill;
                        }
                      });
                    },
                    icon: Icon(iconPassword),
                  ),
                  validator: (val) {
                    if(val!.isEmpty) {
                      return 'Please fill in this field';			
                    } else if(!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^]).{8,}$').hasMatch(val)) {
                      return 'Please enter a valid password';
                    }
                    return null;
                  }
                ),
              ),
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
                            : Theme.of(context).colorScheme.onBackground
                        ),
                      ),
                      Text(
                        "⚈  1 lowercase",
                        style: TextStyle(
                          color: containsLowerCase
                            ? Colors.green
                            : Theme.of(context).colorScheme.onBackground
                        ),
                      ),
                      Text(
                        "⚈  1 number",
                        style: TextStyle(
                          color: containsNumber
                            ? Colors.green
                            : Theme.of(context).colorScheme.onBackground
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
                            : Theme.of(context).colorScheme.onBackground
                        ),
                      ),
                      Text(
                        "⚈  8 minimum character",
                        style: TextStyle(
                          color: contains8Length
                            ? Colors.green
                            : Theme.of(context).colorScheme.onBackground
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: MyTextField(
                  controller: nameController,
                  hintText: 'Name',
                  obscureText: false,
                  keyboardType: TextInputType.name,
                  prefixIcon: const Icon(CupertinoIcons.person_fill),
                  validator: (val) {
                    if(val!.isEmpty) {
                      return 'Please fill in this field';													
                    } else if(val.length > 30) {
                      return 'Name too long';
                    }
                    return null;
                  }
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              !signUpRequired
                ? SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          MyUser myUser = MyUser.empty;
                          myUser.email = emailController.text;
                          // myUser.fname = nameController.text;
                          
                          setState(() {
                            context.read<SignUpBloc>().add(
                              SignUpRequired(
                                myUser,
                                passwordController.text
                              )
                            );
                          });																			
                        }
                      },
                      style: TextButton.styleFrom(
                        elevation: 3.0,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(60)
                        )
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                        child: Text(
                          'Sign Up',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                      )
                    ),
                  )
                : const CircularProgressIndicator()
            ],
          ),
        ),
      ),
		);
  }
}











// import 'package:big_bites/pages/otp_confirmation.dart';
// import 'package:big_bites/pages/sign_in/sign_in.dart';
// import 'package:big_bites/pages/welcome.dart';
// import 'package:flutter/material.dart';

// class CreateAnAccountPage extends StatefulWidget {
//   const CreateAnAccountPage({super.key});

//   @override
//   State<CreateAnAccountPage> createState() => _CreateAnAccountPageState();
// }

// class _CreateAnAccountPageState extends State<CreateAnAccountPage> {
//   bool _isPasswordVisible = false;
//   String? _selectedUserType;

//   TextEditingController email = TextEditingController();
//   TextEditingController name = TextEditingController();
//   TextEditingController usertype = TextEditingController();
//   TextEditingController password = TextEditingController();
//   TextEditingController confirmpassword = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     final deviceHeight = MediaQuery.of(context).size.height;

//     return Scaffold(
//       backgroundColor: const Color(0xFFFFFFFF),
//       body: Stack(
//         children: [
//           // Top Surface Image
//           Positioned(
//             top: deviceHeight * 0.0,
//             left: 0,
//             right: 0,
//             child: SizedBox(
//               width: double.infinity,
//               height: deviceHeight * 0.2,
//               child: Image.asset(
//                 'assets/images/create_an_account/top_surface.png',
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),

//           // Create An Account Text
//           Positioned(
//             top: deviceHeight * 0.225,
//             left: 0,
//             right: 0,
//             child: const Center(
//               child: Column(
//                 children: [
//                   Text(
//                     'Create An Account',
//                     style: TextStyle(
//                       fontFamily: 'Inter',
//                       fontWeight: FontWeight.w600,
//                       fontSize: 24,
//                       color: Color(0xFF1E1E1E),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),

//           // Text Fields
//           Positioned(
//             top: deviceHeight * 0.3,
//             left: 20.0,
//             right: 20.0,
//             child: Column(
//               children: [
//                 // Email Text Field
//                 TextField(
//                   decoration: InputDecoration(
//                     filled: true,
//                     fillColor: const Color(0xFFF5F5F5),
//                     hintText: 'Email',
//                     hintStyle: const TextStyle(
//                       fontFamily: 'Inter',
//                       fontWeight: FontWeight.w400,
//                       fontSize: 16,
//                       color: Colors.grey,
//                     ),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10.0),
//                       borderSide: const BorderSide(
//                         color: Color(0xFFD9D9D9),
//                       ),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10.0),
//                       borderSide: const BorderSide(
//                         color: Color(0xFFD9D9D9),
//                       ),
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 15.0),

//                 Row(
//                   children: [
//                     // First Name Field
//                     Expanded(
//                       child: TextField(
//                         decoration: InputDecoration(
//                           filled: true,
//                           fillColor: const Color(0xFFF5F5F5),
//                           hintText: 'First Name',
//                           hintStyle: const TextStyle(
//                             fontFamily: 'Inter',
//                             fontWeight: FontWeight.w400,
//                             fontSize: 16,
//                             color: Colors.grey,
//                           ),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10.0),
//                             borderSide: const BorderSide(
//                               color: Color(0xFFD9D9D9),
//                             ),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10.0),
//                             borderSide: const BorderSide(
//                               color: Color(0xFFD9D9D9),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),

//                     SizedBox(width: 15.0),

//                     // Last Name Field
//                     Expanded(
//                       child: TextField(
//                         decoration: InputDecoration(
//                           filled: true,
//                           fillColor: const Color(0xFFF5F5F5),
//                           hintText: 'Last Name',
//                           hintStyle: const TextStyle(
//                             fontFamily: 'Inter',
//                             fontWeight: FontWeight.w400,
//                             fontSize: 16,
//                             color: Colors.grey,
//                           ),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10.0),
//                             borderSide: const BorderSide(
//                               color: Color(0xFFD9D9D9),
//                             ),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10.0),
//                             borderSide: const BorderSide(
//                               color: Color(0xFFD9D9D9),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),

//                 const SizedBox(height: 15.0),

//                 // User Type Field
//                 TextField(
//                   decoration: InputDecoration(
//                     filled: true,
//                     fillColor: const Color(0xFFF5F5F5),
//                     hintText: 'User Type',
//                     hintStyle: const TextStyle(
//                       fontFamily: 'Inter',
//                       fontWeight: FontWeight.w400,
//                       fontSize: 16,
//                       color: Colors.grey,
//                     ),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10.0),
//                       borderSide: const BorderSide(
//                         color: Color(0xFFD9D9D9),
//                       ),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10.0),
//                       borderSide: const BorderSide(
//                         color: Color(0xFFD9D9D9),
//                       ),
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 15.0),

//                 // Password Text Field
//                 TextField(
//                   obscureText: !_isPasswordVisible,
//                   decoration: InputDecoration(
//                     filled: true,
//                     fillColor: const Color(0xFFF5F5F5),
//                     hintText: 'Password',
//                     hintStyle: const TextStyle(
//                       fontFamily: 'Inter',
//                       fontWeight: FontWeight.w400,
//                       fontSize: 16,
//                       color: Colors.grey,
//                     ),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10.0),
//                       borderSide: const BorderSide(
//                         color: Color(0xFFD9D9D9),
//                       ),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10.0),
//                       borderSide: const BorderSide(
//                         color: Color(0xFFD9D9D9),
//                       ),
//                     ),
//                     suffixIcon: IconButton(
//                       icon: Icon(
//                         _isPasswordVisible
//                             ? Icons.visibility
//                             : Icons.visibility_off,
//                         color: Colors.grey,
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           _isPasswordVisible = !_isPasswordVisible;
//                         });
//                       },
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 15.0),

//                 // Confirm Password Text Field
//                 TextField(
//                   obscureText: !_isPasswordVisible,
//                   decoration: InputDecoration(
//                     filled: true,
//                     fillColor: const Color(0xFFF5F5F5),
//                     hintText: 'Confirm Password',
//                     hintStyle: const TextStyle(
//                       fontFamily: 'Inter',
//                       fontWeight: FontWeight.w400,
//                       fontSize: 16,
//                       color: Colors.grey,
//                     ),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10.0),
//                       borderSide: const BorderSide(
//                         color: Color(0xFFD9D9D9),
//                       ),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10.0),
//                       borderSide: const BorderSide(
//                         color: Color(0xFFD9D9D9),
//                       ),
//                     ),
//                     suffixIcon: IconButton(
//                       icon: Icon(
//                         _isPasswordVisible
//                             ? Icons.visibility
//                             : Icons.visibility_off,
//                         color: Colors.grey,
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           _isPasswordVisible = !_isPasswordVisible;
//                         });
//                       },
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           // Create An Account Button
//           Positioned(
//             top: deviceHeight * 0.725,
//             left: 20.0,
//             right: 20.0,
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFFF1B136),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(50.0),
//                   side: BorderSide(
//                     color: Colors.black.withOpacity(0.25),
//                     width: 1.0,
//                   ),
//                 ),
//                 minimumSize:
//                     const Size(double.infinity, 50), // Full-width button
//               ),
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => OTPConfirmationPage()),
//                 );
//               },
//               child: const Text(
//                 'Create An Account',
//                 style: TextStyle(
//                   fontFamily: 'Inter',
//                   fontWeight: FontWeight.w400,
//                   fontSize: 18,
//                   color: Colors.black,
//                 ),
//               ),
//             ),
//           ),

//           // Already Have An Account Section
//           Positioned(
//             top: deviceHeight * 0.92,
//             left: 0,
//             right: 0,
//             child: Center(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text(
//                     "Already have an Account?",
//                     style: TextStyle(
//                       fontFamily: 'Inter',
//                       fontWeight: FontWeight.w400,
//                       fontSize: 16,
//                       color: Color(0xFF5F5F5F),
//                     ),
//                   ),
//                   TextButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => const SignInPage()),
//                       );
//                     },
//                     child: const Text(
//                       'Sign In',
//                       style: TextStyle(
//                         fontFamily: 'Inter',
//                         fontWeight: FontWeight.w400,
//                         fontSize: 16,
//                         color: Color(0xFFF1B136),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
