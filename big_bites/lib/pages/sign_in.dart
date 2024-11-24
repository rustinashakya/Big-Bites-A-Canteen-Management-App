import 'package:big_bites/pages/welcome.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Column(
        children: [
          // Top Surface Image
          Container(
            width: double.infinity,
            child: Image.asset(
              'assets/images/sign_in/top_surface.png',
              fit: BoxFit.cover,
            ),
          ),

          // Wrap the rest of the content in Padding
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 20.0), // Space between the two images

                // User Image with specific size
                Center(
                  child: SizedBox(
                    width: 160,
                    height: 160,
                    child: Image.asset(
                      'assets/images/sign_in/user_image.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                SizedBox(height: 5.0), // Space between the image and text

                // Welcome Back Text
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Welcome Back!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                      color: Color(0xFFFFC01E),
                    ),
                  ),
                ),

                SizedBox(height: 20.0),

                // Sign In Text
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Sign In',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      fontSize: 28,
                      color: Color(0xFF1E1E1E),
                    ),
                  ),
                ),

                SizedBox(height: 30.0), // Space before the text fields

                // Email Text Field
                SizedBox(
                  width: double.infinity,
                  child: TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFF5F5F5), // Background color
                      hintText: 'Email',
                      hintStyle: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400, // Regular weight
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: Color(0xFFD9D9D9),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: Color(0xFFD9D9D9),
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20.0), // Space between text fields

                // Password Text Field
                SizedBox(
                  width: double.infinity,
                  child: TextField(
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFF5F5F5), // Background color
                      hintText: 'Password',
                      hintStyle: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400, // Regular weight
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: Color(0xFFD9D9D9),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
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
                ),

                SizedBox(height: 50.0), // Space before the button

                // Sign In Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => WelcomePage()),
                      );
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
                ),

                SizedBox(height: 20.0), // Space before the "Forgot Password?" button

                // Forgot Password? Button
                Center(
                  child: TextButton(
                    onPressed: () {
                      // Add functionality if needed
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400, // Regular weight
                        fontSize: 18,
                        color: Color(0xFF5F5F5F), // Text color
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 80.0), // Space before the next section

                // "Don't have an Account?" and "Sign Up" Section
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an Account?",
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400, // Regular weight
                          fontSize: 18,
                          color: Color(0xFF5F5F5F), // Text color
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Add functionality for Sign Up
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400, // Regular weight
                            fontSize: 18,
                            color: Color(0xFFF1B136), // Highlighted text color
                          ),
                        ),
                      ),
                    ],
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
