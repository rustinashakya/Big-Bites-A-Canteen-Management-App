import 'package:big_bites/pages/dashboard_page/dashboard_page.dart';
import 'package:big_bites/pages/detail_page/detail_page.dart';
import 'package:big_bites/pages/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    return GetMaterialApp(
        title: 'Big Bites - A Canteen Management App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Splash(),
        // home: const DashboardPage()
        // home: CreateAnAccountPage(),
        // home: WelcomePage(),
        );
  }
}
