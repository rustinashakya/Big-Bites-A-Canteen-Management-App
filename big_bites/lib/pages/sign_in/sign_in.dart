import 'package:big_bites/pages/sign_in/bloc/sign_in_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../context/my_text_field.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
	final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
	bool signInRequired = false;
	IconData iconPassword = CupertinoIcons.eye_fill;
	bool obscurePassword = true;
	String? _errorMsg;
	
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInBloc, SignInState>(
			listener: (context, state) {
				if(state is SignInSuccess) {
					setState(() {
					  signInRequired = false;
					});
				} else if(state is SignInProcess) {
					setState(() {
					  signInRequired = true;
					});
				} else if(state is SignInFailure) {
					setState(() {
					  signInRequired = false;
						_errorMsg = 'Invalid email or password';
					});
				}
			},
			child: Form(
        key: _formKey,
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
                errorMsg: _errorMsg,
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Please fill in this field';
                  } else if (!RegExp(r'^[\w-\.]+@([\w-]+.)+[\w-]{2,4}$').hasMatch(val)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                }
              )
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
                errorMsg: _errorMsg,
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Please fill in this field';
                  } else if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^]).{8,}$').hasMatch(val)) {
                    return 'Please enter a valid password';
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
              ),
            ),
            const SizedBox(height: 20),
            !signInRequired
              ? SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<SignInBloc>().add(SignInRequired(
                          emailController.text,
                          passwordController.text)
                        );
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
                        'Sign In',
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
            : const CircularProgressIndicator(),
          ],
        )
      ),
		);
  }
}











// import 'package:big_bites/pages/create_an_account/create_an_account.dart';
// import 'package:big_bites/pages/welcome.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class SignInPage extends StatefulWidget {
//   const SignInPage({super.key});

//   @override
//   State<SignInPage> createState() => _SignInPageState();
// }

// class _SignInPageState extends State<SignInPage> {
//   final TextEditingController email = TextEditingController();
//   final TextEditingController password = TextEditingController();
//   bool _isPasswordVisible = false;

//   Future<void> signIn() async {
//     try {
//       await FirebaseAuth.instance.signInWithEmailAndPassword(
//         email: email.text.trim(),
//         password: password.text.trim(),
//       );
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => WelcomePage()),
//       );
//     } on FirebaseAuthException catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text(e.message ?? "An error occurred")),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final deviceHeight = MediaQuery.of(context).size.height;

//     return Scaffold(
//       backgroundColor: const Color(0xFFFFFFFF),
//       body: Stack(
//         children: [
//           // User Image
//           Positioned(
//             top: deviceHeight * 0.192,
//             left: 0,
//             right: 0,
//             child: Center(
//               child: SizedBox(
//                 width: 300,
//                 height: 300,
//                 child: Image.asset(
//                   'assets/images/sign_in/user.jpg',
//                   fit: BoxFit.contain,
//                 ),
//               ),
//             ),
//           ),
//           // Positioned(
//           //   top: deviceHeight * 0.3,
//           //   left: 0,
//           //   right: 0,
//           //   child: Center(
//           //     child: SizedBox(
//           //       width: 150,
//           //       height: 150,
//           //       child: Image.asset(
//           //         'assets/images/sign_in/user_image.png',
//           //         fit: BoxFit.contain,
//           //       ),
//           //     ),
//           //   ),
//           // ),

//           // Top Surface Image
//           Positioned(
//             top: deviceHeight * 0.0, 
//             left: 0,
//             right: 0,
//             child: SizedBox(
//               width: double.infinity,
//               height: deviceHeight * 0.2, 
//               child: Image.asset(
//                 'assets/images/sign_in/top_surface.png',
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),

//           // Welcome Text
//           Positioned(
//             top: deviceHeight * 0.47,
//             left: 0,
//             right: 0,
//             child: const Center(
//               child: Column(
//                 children: [
//                   Text(
//                     'Welcome Back!',
//                     style: TextStyle(
//                       fontFamily: 'Inter',
//                       fontWeight: FontWeight.bold,
//                       fontSize: 25,
//                       color: Color(0xFFFFC01E),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),

//           // sign In Text
//           Positioned(
//             top: deviceHeight * 0.225,
//             left: 20.0,
//             right: 20.0,
//             // child: Center(
//             child: Column(
//               children: [
//                 Text(
//                   'Sign In',
//                   style: TextStyle(
//                     fontFamily: 'Inter',
//                     fontWeight: FontWeight.w600,
//                     fontSize: 24,
//                     color: Color(0xFF1E1E1E),
//                   ),
//                 ),
//               ],
//             ),
//             // ),
//           ),

//           // Text Fields
//           Positioned(
//             top: deviceHeight * 0.543,
//             left: 20.0,
//             right: 20.0,
//             child: Column(
//               children: [
//                 // Email Text Field
//                 TextField(
//                   controller: email,
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

//                 SizedBox(height: 15.0),

//                 // Password Text Field
//                 TextField(
//                   controller: password,
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
//               ],
//             ),
//           ),

//           // Sign In Button
//           Positioned(
//             top: deviceHeight * 0.725, // Positioned at 80% height
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
//               onPressed: (() => signIn()),
//               child: Text(
//                 'Sign In',
//                 style: TextStyle(
//                   fontFamily: 'Inter',
//                   fontWeight: FontWeight.w400,
//                   fontSize: 18,
//                   color: Colors.black,
//                 ),
//               ),
//             ),
//           ),

//           // Forgot Password
//           Positioned(
//             top: deviceHeight * 0.779, // Positioned at 88% height
//             left: 0,
//             right: 0,
//             child: Center(
//               child: TextButton(
//                 onPressed: () {
//                   // Add functionality
//                 },
//                 child: const Text(
//                   'Forgot Password?',
//                   style: TextStyle(
//                     fontFamily: 'Inter',
//                     fontWeight: FontWeight.w400,
//                     fontSize: 16,
//                     color: Color(0xFF5F5F5F),
//                   ),
//                 ),
//               ),
//             ),
//           ),

//           // Donot Have An Account Section
//           Positioned(
//             top: deviceHeight * 0.92,
//             left: 0,
//             right: 0,
//             child: Center(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text(
//                     "Don't have an Account?",
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
//                         MaterialPageRoute(builder: (context) => CreateAnAccountPage()),
//                       );
//                     },
//                     child: const Text(
//                       'Create One',
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
