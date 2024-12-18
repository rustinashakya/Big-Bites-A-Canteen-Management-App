import 'package:big_bites/pages/otp_confirmation.dart';
import 'package:big_bites/pages/sign_in.dart';
import 'package:big_bites/pages/welcome.dart';
import 'package:flutter/material.dart';

class CreateAnAccountPage extends StatefulWidget {
  const CreateAnAccountPage({super.key});

  @override
  State<CreateAnAccountPage> createState() => _CreateAnAccountPageState();
}

class _CreateAnAccountPageState extends State<CreateAnAccountPage> {
  bool _isPasswordVisible = false;
  String? _selectedUserType;

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: Stack(
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
                'assets/images/create_an_account/top_surface.png',
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Create An Account Text
          Positioned(
            top: deviceHeight * 0.225,
            left: 0,
            right: 0,
            child: const Center(
              child: Column(
                children: [
                  Text(
                    'Create An Account',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                      color: Color(0xFF1E1E1E),
                    ),
                  ),
                ],
              ),
            ),
          ),


          // Text Fields
          Positioned(
            top: deviceHeight * 0.3, 
            left: 20.0,
            right: 20.0,
            child: Column(
              children: [
                // Email Text Field
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFFF5F5F5),
                    hintText: 'Email',
                    hintStyle: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Colors.grey,
                    ),
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
                ),

                const SizedBox(height: 20.0),

                // First Name Field
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFFF5F5F5),
                    hintText: 'Full Name',
                    hintStyle: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Colors.grey,
                    ),
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
                ),

                // SizedBox(height: 20.0),

                // // Last Name Field
                // TextField(
                //   decoration: InputDecoration(
                //     filled: true,
                //     fillColor: Color(0xFFF5F5F5),
                //     hintText: 'Last Name',
                //     hintStyle: TextStyle(
                //       fontFamily: 'Inter',
                //       fontWeight: FontWeight.w400,
                //       fontSize: 16,
                //       color: Colors.grey,
                //     ),
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(10.0),
                //       borderSide: BorderSide(
                //         color: Color(0xFFD9D9D9),
                //       ),
                //     ),
                //     enabledBorder: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(10.0),
                //       borderSide: BorderSide(
                //         color: Color(0xFFD9D9D9),
                //       ),
                //     ),
                //   ),
                // ),

                const SizedBox(height: 20.0),

                // User Type Field
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFFF5F5F5),
                    hintText: 'User Type',
                    hintStyle: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Colors.grey,
                    ),
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
                ),
                
                const SizedBox(height: 20.0),

                // Password Text Field
                TextField(
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFFF5F5F5),
                    hintText: 'Password',
                    hintStyle: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Colors.grey,
                    ),
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
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),

                // Confirm Password Text Field
                TextField(
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFFF5F5F5),
                    hintText: 'Confirm Password',
                    hintStyle: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Colors.grey,
                    ),
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
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Create An Account Button
          Positioned(
            top: deviceHeight * 0.725, 
            left: 20.0,
            right: 20.0,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF1B136),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                  side: BorderSide(
                    color: Colors.black.withOpacity(0.25),
                    width: 1.0,
                  ),
                ),
                minimumSize: const Size(double.infinity, 50), // Full-width button
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OTPConfirmationPage()),
                );
              },
              child: const Text(
                'Create An Account',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            ),
          ),

          // Already Have An Account Section
          Positioned(
            top: deviceHeight * 0.92, 
            left: 0,
            right: 0,
            child: Center(
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
                        MaterialPageRoute(builder: (context) => const SignInPage()),
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
          ),
        ],
      ),
    );
  }
}