import 'package:big_bites/pages/create_an_account/create_an_account.dart';
import 'package:big_bites/pages/sign_in/sign_in.dart';
import 'package:flutter/material.dart';

void main() => runApp(
  const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ChooseToSignIn(),
  ),
);

class ChooseToSignIn extends StatefulWidget {
  const ChooseToSignIn({super.key});

  @override
  State<ChooseToSignIn> createState() => _ChooseToSignInState();
}

class _ChooseToSignInState extends State<ChooseToSignIn> {
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: Stack(
        children: [
          // Top Surface Image
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              height: deviceHeight * 0.3,
              child: Image.asset(
                'assets/images/choose_to_sign_in/top_surface.png',
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),

          // Big Bites Logo
          Positioned(
            top: deviceHeight * 0.27, 
            left: 0,
            right: 0,
            child: Center(
              child: SizedBox(
                width: 350, 
                height: 350, 
                child: Image.asset(
                  'assets/images/splash/BigBites.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),

          // Buttons
          Positioned(
            top: deviceHeight * 0.77, 
            left: 20.0,
            right: 20.0,
            child: Column(
              children: [
                // Sign In Button
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
                    minimumSize: const Size(double.infinity, 50), 
                  ),
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
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ),

                const SizedBox(height: 15.0), 

                // Create an Account Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFFFFF), 
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      side: BorderSide(
                        color: Colors.black.withOpacity(0.25), 
                        width: 1.0,
                      ),
                    ),
                    minimumSize: const Size(double.infinity, 50), 
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CreateAnAccountPage()),
                    );
                  },
                  child: const Text(
                    'Create an Account',
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
        ],
      ),
    );
  }
}
