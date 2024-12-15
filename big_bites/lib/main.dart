
import 'package:big_bites/pages/admin/admin_log_in.dart';
import 'package:big_bites/pages/admin_dashboard_page/admin_dashboard_page.dart';
import 'package:big_bites/pages/detail_page/detail_page.dart';
import 'package:big_bites/pages/order_now/order_now.dart';
import 'package:big_bites/pages/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    title: 'Big Bites - A Canteen Management App',
    debugShowCheckedModeBanner: false,
    home: Splash(),
  ));
}
