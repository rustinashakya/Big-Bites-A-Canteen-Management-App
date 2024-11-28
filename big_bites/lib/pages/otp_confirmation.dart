import 'package:big_bites/pages/sign_in.dart';
import 'package:big_bites/pages/welcome.dart';
import 'package:flutter/material.dart';

class OTPConfirmationPage extends StatefulWidget {
  const OTPConfirmationPage({super.key});

  @override
  State<OTPConfirmationPage> createState() => _OTPConfirmationPageState();
}

class _OTPConfirmationPageState extends State<OTPConfirmationPage> {
  final bool _isPasswordVisible = false;

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
                'assets/images/otp_confirmation/top_surface.png',
                fit: BoxFit.cover,
              ),
            ),
          ),

          // OTP Confirmation Text
          Positioned(
            top: deviceHeight * 0.35,
            left: 0,
            right: 0,
            child: const Center(
              child: Column(
                children: [
                  Text(
                    'OTP Confirmation',
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

          Positioned(
            top: deviceHeight * 0.4,
            left: 20.0,
            right: 20.0,
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, 
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'We send you email. Please check your mail and complete OTP Code.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 16,
                      color: Color(0xFF5F5F5F),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            top: deviceHeight * 0.49,
            left: 20.0,
            right: 20.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(6, (index) {
                return SizedBox(
                  width: 50,
                  child: TextFormField(
                    onChanged: (value) {
                      if (value.length == 1 && index < 5) {
                        FocusScope.of(context).nextFocus(); // Move to the next field
                      } else if (value.isEmpty && index > 0) {
                        FocusScope.of(context).previousFocus(); // Move to the previous field
                      }
                    },
                    textAlign: TextAlign.center,
                    maxLength: 1,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      counterText: "", // Hides the character counter
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Color(0xFFF1B136)),
                      ),
                      filled: true,
                      fillColor: const Color(0xFFF6F6F6),
                    ),
                  ),
                );
              }),
            ),
          ),


          // Confirm Button
          Positioned(
            top: deviceHeight * 0.6, 
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
                  MaterialPageRoute(builder: (context) => const WelcomePage()),
                );
              },
              child: const Text(
                'Confirm',
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
          )
        ]
      ),
    );
  }
}