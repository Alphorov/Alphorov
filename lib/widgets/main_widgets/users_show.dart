import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/bloc/user_bloc/user_block.dart';
import 'package:flutter_project/bloc/user_bloc/user_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UsersShow extends StatefulWidget {
  const UsersShow({Key? key}) : super(key: key);

  @override
  _UsersShowState createState() => _UsersShowState();
}

class _UsersShowState extends State<UsersShow> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserStates>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                        border: Border.all(width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Text('User'),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: SizedBox(
                              child: Container(
                                height: 1,
                                width: double.infinity,
                                color: Colors.black,
                              ),
                              height: 2,
                            ),
                          ),
                          Text(
                            state is UserDoneState
                                ? 'Name: ${state.user.name.toString()}'
                                : '',
                          ),
                          Text(
                            state is UserDoneState
                                ? 'Date: ${state.user.date.toString()}'
                                : '',
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              OutlinedButton(
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setStringList('users', []);
                    prefs.setStringList('current_user', []);
                    Navigator.of(context).pushReplacementNamed('/reg');
                  },
                  child: Text('Clean user'))
            ],
          ),
        );
      },
    );
  }
}
