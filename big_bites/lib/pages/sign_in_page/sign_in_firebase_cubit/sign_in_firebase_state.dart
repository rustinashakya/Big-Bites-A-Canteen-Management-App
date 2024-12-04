part of 'sign_in_firebase_cubit.dart';

@freezed
class SignInFirebaseState with _$SignInFirebaseState {
  const factory SignInFirebaseState.initial() = _Initial;
  const factory SignInFirebaseState.loading() = _Loading;
  const factory SignInFirebaseState.success(User? user) = _Success;
  const factory SignInFirebaseState.error() = _Error;
}
