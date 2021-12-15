import 'package:flutter/material.dart';
import 'package:flutter_project/models/dogs_model.dart';

@immutable
abstract class DogsState {
  const DogsState(this.dog);
  final Dogs? dog;
}

@immutable
class DogInitialState extends DogsState {
  const DogInitialState() : super(null);
}

@immutable
class LoadingState extends DogsState {
  const LoadingState() : super(null);
}

@immutable
class LoadedState extends DogsState {
  const LoadedState(Dogs res) : super(res);
}

@immutable
class ErrorState extends DogsState {
  const ErrorState(this.error) : super(null);

  final String error;
}
