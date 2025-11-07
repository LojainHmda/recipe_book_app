part of 'auth_cubit.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}
class SignIn extends AuthState {
  final UserModel user;
  SignIn({required this.user});
}
class AuthError extends AuthState {
  final String message;
AuthError(this.message) {
    print(message);
  }
}

class UserUpdated extends AuthState {
  final UserModel user;
  UserUpdated({required this.user});
}