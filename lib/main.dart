import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/bloc/auth_bloc/auth_block.dart';
import 'package:flutter_project/bloc/dogs_api_block/dogs_bloc.dart';
import 'package:flutter_project/bloc/dogs_api_block/dogs_events.dart';
import 'package:flutter_project/bloc/reg_bloc/reg_bloc.dart';
import 'package:flutter_project/bloc/user_bloc/user_block.dart';
import 'package:flutter_project/bloc/user_bloc/user_event.dart';
import 'package:flutter_project/bloc/user_bloc/user_state.dart';

import 'package:flutter_project/widgets/auth/auth_widget.dart';
import 'api/api_implement.dart';
import 'bloc/auth_bloc/auth_states.dart';
import 'widgets/auth/reg_widget.dart';
import 'widgets/main_widgets/main_screen_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (c) => DogsBloc(NewsImplementApi())..add(DogGetEvent())),
        BlocProvider(
          create: (c) => RegBloc(),
        ),
        BlocProvider(
          create: (c) => AuthBloc(),
          lazy: false,
        ),
        BlocProvider(
          create: (c) => UserBloc()..add(InitUserEvent()),
          lazy: false,
        )
      ],
      child: BlocListener<AuthBloc, AuthStates>(
        listener: (context, state) {
          if (state is AuthSuccessState) {
            context.read<UserBloc>().add(AddUserEvent(user: state.user));
          }
        },
        child: BlocBuilder<UserBloc, UserStates>(
          builder: (context, state) {
            return MaterialApp(
              home: state is UserDoneState ? MainScreenWidget() : RegWidget(),
              routes: {
                '/reg': (context) => RegWidget(),
                '/auth': (context) => AuthWidget(),
                '/main': (context) => MainScreenWidget(),
              },
            );
          },
        ),
      ),
    );
  }
}
