import 'package:big_bites/app.dart';
import 'package:big_bites/simple_bloc_observer.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:user_repository/user_repository.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp(FirebaseUserRepo()));
}


