import 'package:flutter/material.dart';

void main() => runApp(
  MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ChooseToSignIn(),
  ),
);

class ChooseToSignIn extends StatefulWidget {
  @override
  State<ChooseToSignIn> createState() => _ChooseToSignInState();
}

class _ChooseToSignInState extends State<ChooseToSignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Stack(
        children: [
          Column(
            children: [
              // First Image
              Container(
                width: double.infinity,
                child: Image.asset(
                  'assets/images/choose_to_sign_in/top_surface.png',
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 8.0),

              // Second Image
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.4,
                child: Image.asset(
                  'assets/images/choose_to_sign_in/BigBites.png',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),

          // Buttons at 70% of device height
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.1,
            left: 20.0,
            right: 20.0,
            child: Column(
              children: [
                // Sign In Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFF1B136), // Background color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      side: BorderSide(
                        color: Colors.black.withOpacity(0.25), // Black border with 25% opacity
                        width: 2.0,
                      ),
                    ),
                    minimumSize: Size(double.infinity, 60), // Full-width button
                  ),
                  onPressed: () {
                    // Add your sign-in logic here
                  },
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                      fontFamily: 'Inter', // Custom font
                      fontWeight: FontWeight.w400, // Regular weight
                      fontSize: 22, // Font size in px
                      color: Colors.black, // Text color
                    ),
                  ),
                ),

                SizedBox(height: 16.0), // Gap between buttons

                // Create an Account Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFFFFFF), // Background color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      side: BorderSide(
                        color: Colors.black.withOpacity(0.25), // Black border with 25% opacity
                        width: 2.0,
                      ),
                    ),
                    minimumSize: Size(double.infinity, 60), // Full-width button
                  ),
                  onPressed: () {
                    // Add your create account logic here
                  },
                  child: Text(
                    'Create an Account',
                    style: TextStyle(
                      fontFamily: 'Inter', // Custom font
                      fontWeight: FontWeight.w400, // Regular weight
                      fontSize: 22, // Font size in px
                      color: Colors.black, // Text color
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
