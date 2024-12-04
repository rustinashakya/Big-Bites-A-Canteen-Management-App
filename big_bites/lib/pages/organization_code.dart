import 'package:big_bites/pages/choose_to_sign_in.dart';
import 'package:big_bites/pages/create_an_account.dart';
import 'package:big_bites/pages/sign_in/sign_in.dart';
import 'package:flutter/material.dart';

void main() => runApp(
  MaterialApp(
    debugShowCheckedModeBanner: false,
    home: OrganizationCode(),
  ),
);

class OrganizationCode extends StatefulWidget {
  const OrganizationCode({super.key});

  @override
  State<OrganizationCode> createState() => _OrganizationCodeState();
}

class _OrganizationCodeState extends State<OrganizationCode> {
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
                'assets/images/organization_code/top_surface.png',
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

          // Text Fields
          Positioned(
            top: deviceHeight * 0.76, 
            left: 20.0,
            right: 20.0,
            child: Column(
              children: [
                // Email Text Field
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFFF5F5F5),
                    hintText: 'Organization Code',
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


                SizedBox(height: 15.0), // Gap between buttons

                // Let's go Button 
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    // Background color
                    backgroundColor: Color(0xFFF1B136),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      side: BorderSide(
                        color: Colors.black.withOpacity(0.25), 
                        width: 1.0,
                      ),
                    ),
                    minimumSize: Size(double.infinity, 50), // Full-width button
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChooseToSignIn()),
                    );
                  },
                  child: const Text(
                    "Let's Go",
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



