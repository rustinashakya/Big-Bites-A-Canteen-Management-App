import 'package:flutter/material.dart';

class CreateAnAccountPage extends StatefulWidget {
  @override
  State<CreateAnAccountPage> createState() => _CreateAnAccountPageState();
}

class _CreateAnAccountPageState extends State<CreateAnAccountPage> {
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
              'assets/images/create_an_account/top_surface.png',
              fit: BoxFit.cover,
            ),
          ),

          // Wrap the rest of the content in Padding
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 20.0),

                // Sign In Text
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Sign Up',
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


                SizedBox(height: 20.0), // Space between text fields

                // Confirm Password Text Field
                SizedBox(
                  width: double.infinity,
                  child: TextField(
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFF5F5F5), // Background color
                      hintText: 'Confirm Password',
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

              ],
            ),
          ),
        ],
      ),
    );
  }
}