part of 'auth_cubit.dart';

abstract class AuthState {}

class Logout extends AuthState {}

class ShowSignUpScreen extends AuthState {}

class ShowSignInScreen extends AuthState {}

class AuthLoading extends AuthState {}

class SignInSucsess extends AuthState {
  final UserModel user;
  SignInSucsess({required this.user});
}

class SignUpSucsess extends AuthState {
  final UserModel user;
  SignUpSucsess({required this.user});
}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message) {
    print(message);
  }
}
