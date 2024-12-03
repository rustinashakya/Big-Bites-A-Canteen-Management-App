import 'package:big_bites/pages/dashboard_page/home_page/register_new_user_cubit/register_new_user_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';
import 'package:big_bites/pages/splash.dart';
import 'package:big_bites/pages/dashboard_page/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

import 'getit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider<RegisterNewUserCubit>(
          create: (context) => locator<RegisterNewUserCubit>(),
        ),
      ],
      child: MaterialApp(
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
      ),
    );
  }
}
