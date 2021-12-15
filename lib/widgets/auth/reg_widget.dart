import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/bloc/reg_bloc/reg_bloc.dart';
import 'package:flutter_project/bloc/reg_bloc/reg_events.dart';
import 'package:flutter_project/bloc/reg_bloc/reg_states.dart';

class RegWidget extends StatefulWidget {
  const RegWidget({Key? key}) : super(key: key);

  @override
  _RegWidgetState createState() => _RegWidgetState();
}

class _RegWidgetState extends State<RegWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Center(child: Text('Регистрация')),
      ),
      body: Column(
        children: [_FormWidget()],
      ),
    );
  }
}

class _FormWidget extends StatefulWidget {
  _FormWidget({Key? key}) : super(key: key);

  @override
  __FormWidgetState createState() => __FormWidgetState();
}

class __FormWidgetState extends State<_FormWidget> {
  static const _formDecoration = InputDecoration(
      focusedBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.blueGrey)),
      border: OutlineInputBorder(),
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0));

  final _loginTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _nameTextController = TextEditingController();

  void reg() {
    final bloc = context.read<RegBloc>();
    bloc.add(RegEvent(
      passwordText: _passwordTextController.text,
      loginText: _loginTextController.text,
      nameText: _nameTextController.text,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegBloc, RegStates>(
      listener: (context, state) {
        if (state is RegSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              'Регистрация успешна',
              textAlign: TextAlign.center,
            ),
            backgroundColor: Colors.blue,
          ));
          Navigator.of(context).pushReplacementNamed('/auth');
        }
        if (state is RegFailedState) {
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
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Имя'),
                TextField(
                  controller: _nameTextController,
                  decoration: _formDecoration,
                ),
                SizedBox(
                  height: 15,
                ),
                Text('Логин'),
                TextField(
                  controller: _loginTextController,
                  decoration: _formDecoration,
                ),
                SizedBox(
                  height: 15,
                ),
                Text('Пароль'),
                TextField(
                  controller: _passwordTextController,
                  decoration: _formDecoration,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    OutlinedButton(
                        onPressed: () => reg(),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Зарегистрироваться',
                            style: TextStyle(color: Colors.black),
                          ),
                        )),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
