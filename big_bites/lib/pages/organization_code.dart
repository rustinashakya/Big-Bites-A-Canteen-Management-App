import 'package:big_bites/pages/choose_to_sign_in.dart';
import 'package:flutter/material.dart';

void main() => runApp(
  MaterialApp(
    debugShowCheckedModeBanner: false,
    home: OrganizationCode(),
  ),
);

class OrganizationCode extends StatefulWidget {
  @override
  State<OrganizationCode> createState() => _OrganizationCodeState();
}

class _OrganizationCodeState extends State<OrganizationCode> {
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
                  'assets/images/organization_code/BigBites.png',
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
                // text field
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFF5F5F5), // Background color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      side: BorderSide(
                        color: Colors.black.withOpacity(0.25), // Black border with 25% opacity
                        width: 2.0,
                      ),
                    ),
                    minimumSize: Size(double.infinity, 60), // Full-width button
                  ),
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => SignInPage()),
                    // );
                  },
                  child: Text(
                    'Add Your Organization Code',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: 'Inter', // Custom font
                      fontWeight: FontWeight.w400, // Regular weight
                      fontSize: 18, // Font size in px
                      color: Color(0xFF5F5F5F), // Text color
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
                        color: Colors.black.withOpacity(0.25), // Black border with 25% opacity
                        width: 2.0,
                      ),
                    ),
                    minimumSize: Size(double.infinity, 60), // Full-width button
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChooseToSignIn()),
                    );
                  },
                  child: Text(
                    "Let's Go",
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




