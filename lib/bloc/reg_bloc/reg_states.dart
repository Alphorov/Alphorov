import 'package:flutter/material.dart';
import 'package:flutter_project/models/user.dart';

@immutable
abstract class RegStates {
  const RegStates();
}

@immutable
class RegInitialState extends RegStates {
  const RegInitialState();
}

@immutable
class RegSuccessState extends RegStates {
  RegSuccessState({required this.user});
  final User user;
}

@immutable
class RegFailedState extends RegStates {
  const RegFailedState({required this.errorText});
  final String errorText;
}

@immutable
class RegProcessingState extends RegStates {
  const RegProcessingState();
}

@immutable
class RegErrorState extends RegStates {
  const RegErrorState({required this.error});
  final String error;
}
