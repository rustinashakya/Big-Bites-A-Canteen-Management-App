import 'package:big_bites/pages/dashboard_page/dashboard_page.dart';
import 'package:big_bites/pages/sign_in_page/sign_in.dart';
import 'package:big_bites/services/auth_user_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: AuthUserRepo.auth.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.hasData) {
            return DashboardPage();
          }
          return SignInPage();
        });
  }
}
