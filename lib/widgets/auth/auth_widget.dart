import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/bloc/auth_bloc/auth_block.dart';
import 'package:flutter_project/bloc/auth_bloc/auth_events.dart';
import 'package:flutter_project/bloc/auth_bloc/auth_states.dart';

class AuthWidget extends StatelessWidget {
  const AuthWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Center(child: Text('Авторизация')),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: _AuthFormWidget(),
          )
        ],
      ),
    );
  }
}

class _AuthFormWidget extends StatefulWidget {
  const _AuthFormWidget({Key? key}) : super(key: key);

  @override
  __AuthFormWidgetState createState() => __AuthFormWidgetState();
}

class __AuthFormWidgetState extends State<_AuthFormWidget> {
  final _loginAuthTextController = TextEditingController();
  final _passwordAuthTextController = TextEditingController();

  static const _formDecoration = InputDecoration(
      focusedBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.blueGrey)),
      border: OutlineInputBorder(),
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0));

  void login() {
    final bloc = context.read<AuthBloc>();
    bloc.add(AuthEvent(
        loginText: _loginAuthTextController.text,
        pswrdText: _passwordAuthTextController.text));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthStates>(
      listener: (context, state) {
        if (state is AuthSuccessState) {
          Navigator.of(context).pushReplacementNamed('/main');
        }
        if (state is AuthFailedState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              state.errorText,
              textAlign: TextAlign.center,
            ),
            backgroundColor: Colors.blue,
          ));
        }
      },
      builder: (context, state) {
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: 15,
          ),
          Text('Логин'),
          TextField(
            controller: _loginAuthTextController,
            decoration: _formDecoration,
          ),
          SizedBox(
            height: 15,
          ),
          Text('Пароль'),
          TextField(
            controller: _passwordAuthTextController,
            decoration: _formDecoration,
          ),
          SizedBox(
            height: 20,
          ),
          Center(
              child: OutlinedButton(
                  onPressed: () => login(),
                  child: Text(
                    'Войти',
                    style: TextStyle(color: Colors.black),
                  ))),
        ]);
      },
    );
  }
}
