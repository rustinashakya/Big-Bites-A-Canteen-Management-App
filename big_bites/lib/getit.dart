import 'package:big_bites/pages/dashboard_page/home_page/register_new_user_cubit/register_new_user_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<RegisterNewUserCubit>(
      () => RegisterNewUserCubit(FirebaseAuth.instance));
}
