import 'package:big_bites/context/fonts.dart';
import 'package:big_bites/pages/admin_dashboard_page/admin_dashboard_page.dart';
import 'package:big_bites/pages/log_in.dart';
import 'package:big_bites/pages/onboard.dart';
import 'package:big_bites/pages/welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class WelcomePagePCPS extends StatefulWidget {
  @override
  _WelcomePagePCPSState createState() => _WelcomePagePCPSState();
}

class _WelcomePagePCPSState extends State<WelcomePagePCPS> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Onboard(),
      ),
    );
  }

  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Stack(
        children: [
          // Top Surface Image
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/images/welcome/top_surface.png',
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),

          // Center Texts
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 10), // Space between the texts
                Text(
                  "Welcome to Big Bites",
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    fontSize: 28,
                    color: Color(0xFF1E1E1E),
                  ),
                ),
                Text(
                  "A Canteen Management App",
                  style: TextStyle(
                    fontFamily: 'Kaushan',
                    fontWeight: FontWeight.w600,
                    fontSize: 28,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
                Text(
                  "PCPS College",
                  style: TextStyle(
                    fontFamily: 'Kaushan',
                    fontWeight: FontWeight.w600,
                    fontSize: 28,
                    color: Color(0xFFFFFFFF),
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