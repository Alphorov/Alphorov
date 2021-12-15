import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_project/api/api.dart';
import 'package:flutter_project/bloc/dogs_api_block/dogs_events.dart';
import 'package:flutter_project/bloc/dogs_api_block/dogs_states.dart';

class DogsBloc extends Bloc<DogsEvent, DogsState> {
  DogsBloc(this._api) : super(const DogInitialState()) {
    on<DogGetEvent>((e, emitter) async {
      emitter.call(LoadingState());
      try {
        final res = await _api.getDogs().timeout(const Duration(seconds: 5));
        emitter.call(LoadedState(res));
      } on TimeoutException {
        emitter.call(const ErrorState('Время запроса иссякло!'));
      } catch (e) {
        emitter.call(ErrorState('$e'));
      }
    });
  }

  final NewsApi _api;
}
