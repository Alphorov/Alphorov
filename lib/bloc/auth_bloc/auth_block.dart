import 'package:bloc/bloc.dart';
import 'package:flutter_project/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_events.dart';
import 'auth_states.dart';

class AuthBloc extends Bloc<AuthEvents, AuthStates> {
  AuthBloc() : super(AuthInitialState()) {
    on<AuthEvent>(auth);
  }

  Future<void> auth(AuthEvent e, Emitter<AuthStates> emitter) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userInfo = prefs.getStringList('users') ?? [];
    final _usersParsed = <User>[];

    try {
      for (var element in userInfo) {
        _usersParsed.add(User.fromJson(element));
      }

      for (var element in _usersParsed) {
        final _login = element.login;
        final _password = element.pswrd;
        if (e.loginText != '' && e.pswrdText != '') {
          if (e.loginText.toLowerCase() == _login?.toLowerCase()) {
            if (e.pswrdText == _password) {
              prefs.setString('current_user', element.toJson());
              final a = prefs.getString('current_user');
              print(a);
              return emitter.call(AuthSuccessState(user: element));
            } else {
              return emitter.call(
                  AuthFailedState(errorText: 'Не верный логин или пароль'));
            }
          } else {
            return emitter
                .call(AuthFailedState(errorText: 'Не верный логин или пароль'));
          }
        } else {
          return emitter.call(AuthFailedState(errorText: 'Заполните все поля'));
        }
      }
    } catch (e) {
      emitter.call(AuthErrorState(error: '$e'));
    }
  }
}
