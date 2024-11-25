import 'package:big_bites/pages/choose_to_sign_in.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    // Reduce the duration for better user experience
    await Future.delayed(Duration(milliseconds: 2500));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ChooseToSignIn(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Big Bites Logo
          Positioned(
            top: deviceHeight * 0.27, // Position dynamically at 27% of screen height
            left: 0,
            right: 0,
            child: Center(
              child: SizedBox(
                width: 350, // Adjusted width
                height: 350, // Adjusted height
                child: Image.asset(
                  'assets/images/splash/BigBites.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
