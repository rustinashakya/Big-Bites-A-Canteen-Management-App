import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:big_bites/pages/splash.dart';
import 'package:big_bites/pages/dashboard_page/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Big Bites - A Canteen Management App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Splash(),
      // home: const Splash(),
      // home: const DashboardPage(),
      // home: CreateAnAccountPage(),
      // home: WelcomePage(),
      // home: OrderNow(),
      // home: DetailPage(),
    );
  }
}
