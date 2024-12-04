import 'package:big_bites/pages/choose_to_sign_in.dart';
import 'package:big_bites/pages/create_an_account.dart';
import 'package:big_bites/pages/sign_in_page/sign_in.dart';
import 'package:flutter/material.dart';

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
          Column(
            children: [
              // First Image
              Container(
                width: double.infinity,
                child: Image.asset(
                  'assets/images/organization_code/top_surface.png',
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 8.0),

              // Second Image
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.4,
                child: Image.asset(
                  'assets/images/splash/BigBites.png',
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),

          // Text Fields
          Positioned(
            top: deviceHeight * 0.768,
            left: 20.0,
            right: 20.0,
            child: Column(
              children: [
                // text field
                SizedBox(
                  width: double.infinity,
                  child: TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFF5F5F5), // Background color
                      hintText: 'Add Your Organization Code ',
                      hintStyle: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400, // Regular weight
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                          color: Color(0xFFD9D9D9),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                          color: Color(0xFFD9D9D9),
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 16.0), // Gap between buttons

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
                    minimumSize: Size(double.infinity, 60), // Full-width button
                  ),
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => ChooseToSignIn()),
                    // );
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
