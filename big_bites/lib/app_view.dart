import 'package:big_bites/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:big_bites/pages/dashboard_page/dashboard_page.dart';
import 'package:big_bites/pages/sign_in/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Big Bites - A Canteen Management App',
      debugShowCheckedModeBanner: false,
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: ((context, state){
            if(state.status == AuthenticationStatus.authenticated){
              return DashboardPage();
            } else{
              return SignInPage();
            }
          }
        ),
      ),
    );
  }
}