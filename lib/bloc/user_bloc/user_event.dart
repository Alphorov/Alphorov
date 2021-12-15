import 'package:flutter/material.dart';
import 'package:flutter_project/models/user.dart';

@immutable
abstract class UserEvents {
  const UserEvents();
}

@immutable
class AddUserEvent extends UserEvents {
  AddUserEvent({required this.user});
  final User user;
}

@immutable
class InitUserEvent extends UserEvents {
  InitUserEvent();
}
