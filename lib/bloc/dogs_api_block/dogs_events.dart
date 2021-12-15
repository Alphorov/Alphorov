import 'package:flutter/material.dart';

@immutable
abstract class DogsEvent {
  const DogsEvent();
}

@immutable
class DogGetEvent extends DogsEvent {
  const DogGetEvent();
}
