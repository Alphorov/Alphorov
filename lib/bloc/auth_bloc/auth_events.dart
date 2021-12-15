import 'package:flutter/material.dart';

@immutable
abstract class AuthEvents {
  const AuthEvents();
}

@immutable
class AuthEvent extends AuthEvents {
  const AuthEvent({required this.loginText, required this.pswrdText});
  final String loginText;
  final String pswrdText;
}
