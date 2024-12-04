part of 'register_new_user_cubit.dart';

@freezed
class RegisterNewUserState with _$RegisterNewUserState {
  const factory RegisterNewUserState.initial() = _Initial;
  const factory RegisterNewUserState.loading() = _Loading;
  const factory RegisterNewUserState.success() = _Success;
  const factory RegisterNewUserState.error(String message) = _Error;
}
