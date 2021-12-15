import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/bloc/dogs_api_block/dogs_bloc.dart';
import 'package:flutter_project/bloc/dogs_api_block/dogs_events.dart';
import 'package:flutter_project/bloc/dogs_api_block/dogs_states.dart';

class DogsWidget extends StatefulWidget {
  DogsWidget({Key? key}) : super(key: key);

  @override
  _DogsWidgetState createState() => _DogsWidgetState();
}

class _DogsWidgetState extends State<DogsWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DogsBloc, DogsState>(builder: (ctx, state) {
      return Container(
        width: double.infinity,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (state is ErrorState)
              Text('Непредвиденная ошибка.${state.error}'),
            Container(
                height: 350,
                width: 350,
                child: state is LoadedState
                    ? Image.network(
                        state.dog!.message,
                        fit: BoxFit.cover,
                      )
                    : state is LoadingState
                        ? CircularProgressIndicator()
                        : SizedBox.expand()),
            SizedBox(height: 20),
            CupertinoButton(
                color: Colors.amber,
                onPressed: () {
                  context.read<DogsBloc>().add(DogGetEvent());
                },
                child: Text('Получить догича'))
          ],
        ),
      );
    });
  }
}
