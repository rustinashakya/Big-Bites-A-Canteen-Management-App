import 'package:big_bites/pages/addmenu.dart';
import 'package:big_bites/pages/create_an_account.dart';
import 'package:big_bites/pages/organization_code.dart';
import 'package:big_bites/pages/sign_in.dart';
import 'package:big_bites/pages/splash.dart';
import 'package:big_bites/pages/welcome.dart';
import 'package:flutter/material.dart';

void main() {
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
      // home: const Splash(),
      // home: CreateAnAccountPage(),
      // home: WelcomePage(),
      //home: OrganizationCode(),
      home: const AddMenu(),
    );
  }
}

