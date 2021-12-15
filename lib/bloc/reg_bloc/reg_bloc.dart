import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_project/bloc/reg_bloc/reg_events.dart';
import 'package:flutter_project/bloc/reg_bloc/reg_states.dart';
import 'package:flutter_project/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegBloc extends Bloc<RegEvents, RegStates> {
  RegBloc() : super(RegInitialState()) {
    on<RegEvent>(_register);
  }

  Future<void> _register(RegEvent e, Emitter<RegStates> emitter) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (e.loginText != '' && e.nameText != '' && e.passwordText != '') {
      final _regCkeck = await _regCheck(e.loginText);
      if (_regCkeck) {
        try {
          final _user = User(
            name: e.nameText,
            login: e.loginText,
            pswrd: e.passwordText,
            date: DateTime.now(),
          );

          final jsonUser = _user.toJson();
          final users = prefs.getStringList('users') ?? [];

          users.add(jsonUser);
          prefs.setStringList('users', users);

          emitter.call(RegSuccessState(user: _user));
          final a = prefs.get('users');
          print(a);
        } catch (e) {
          emitter.call(RegErrorState(error: "$e"));
        }
      } else {
        emitter.call(RegFailedState(errorText: 'Этот логин уже используется'));
      }
    } else {
      emitter.call(RegFailedState(errorText: 'Заполните все поля'));
    }
  }

  Future<bool> _regCheck(String loginText) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final userInfo = prefs.getStringList('users') ?? [];
    final _usersParsed = <User>[];

    for (var element in userInfo) {
      _usersParsed.add(User.fromJson(element));
    }

    final _listUsers =
        _usersParsed.where((element) => element.login == loginText);

    if (_listUsers.isNotEmpty) {
      return false;
    }

    return true;
  }
}
