import 'package:big_bites/main.dart';
import 'package:big_bites/pages/choose_to_sign_in.dart';
import 'package:big_bites/pages/home.dart';
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
    _navigatetohome();
  }

  _navigatetohome() async {
    await Future.delayed(Duration(milliseconds: 2500), () {});
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ChooseToSignIn(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/splash/BigBites.png',
              fit: BoxFit.cover, 
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
