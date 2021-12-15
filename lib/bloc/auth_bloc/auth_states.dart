import 'package:flutter/material.dart';
import 'package:flutter_project/models/user.dart';

@immutable
abstract class AuthStates {
  const AuthStates();
}

@immutable
class AuthInitialState extends AuthStates {
  const AuthInitialState();
}

@immutable
class AuthSuccessState extends AuthStates {
  AuthSuccessState({required this.user});
  final User user;
}

@immutable
class AuthFailedState extends AuthStates {
  const AuthFailedState({required this.errorText});
  final String errorText;
}

@immutable
class AuthErrorState extends AuthStates {
  const AuthErrorState({required this.error});
  final String error;
}
