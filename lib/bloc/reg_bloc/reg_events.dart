import 'package:flutter/material.dart';

@immutable
abstract class RegEvents {
  const RegEvents();
}

@immutable
class RegEvent extends RegEvents {
  const RegEvent(
      {required this.passwordText,
      required this.loginText,
      required this.nameText});

  final String passwordText;
  final String loginText;
  final String nameText;
}
