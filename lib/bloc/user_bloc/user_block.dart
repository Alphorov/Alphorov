import 'package:bloc/bloc.dart';
import 'package:flutter_project/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvents, UserStates> {
  UserBloc() : super(UserInitialState()) {
    on<InitUserEvent>(_init);
    on<AddUserEvent>(_takeState);
  }

  Future<void> _init(InitUserEvent e, Emitter<UserStates> emitter) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      final currentUser = prefs.getString('current_user');
      if (currentUser != null) {
        final _user = User.fromJson(currentUser);
        emitter.call(UserDoneState(user: _user));
      } else {
        emitter.call(UserUnauthorizedState());
      }
    } catch (e) {
      emitter.call(UserErrorState(error: '$e'));
    }
  }

  void _takeState(AddUserEvent e, Emitter<UserStates> emitter) {
    emitter.call(UserDoneState(user: e.user));
  }
}
