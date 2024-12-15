
import 'package:big_bites/pages/welcome.dart';
import 'package:big_bites/pages/welcome_pcps.dart';
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
    await Future.delayed(const Duration(milliseconds: 1500));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => WelcomePagePCPS(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          width: 300,
          height: 300,
          child: Image.asset(
            'assets/images/splash/BigBites.png',
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}