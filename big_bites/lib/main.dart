import 'package:big_bites/pages/create_an_account.dart';
import 'package:big_bites/pages/sign_in.dart';
import 'package:big_bites/pages/splash.dart';
import 'package:big_bites/pages/welcome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Big Bites - A Canteen Management App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Splash(),
      // home: CreateAnAccountPage(),
      // home: WelcomePage(),
    );
  }
}

