import 'package:flutter/cupertino.dart';
import 'package:flutter_project/models/user.dart';

@immutable
abstract class UserStates {
  const UserStates();
}

@immutable
class UserInitialState extends UserStates {
  UserInitialState();
}

@immutable
class UserDoneState extends UserStates {
  UserDoneState({required this.user});
  final User user;
}

@immutable
class UserUnauthorizedState extends UserStates {
  UserUnauthorizedState();
}

@immutable
class UserErrorState extends UserStates {
  UserErrorState({required this.error});
  final String error;
}
