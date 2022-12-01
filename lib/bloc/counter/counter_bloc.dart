import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, num> {
  CounterBloc() : super(0) {
    on<CounterEvent>((event, emit) {});
    on<IncrementEvent>(
      (event, emit) {
        emit(state + 1);
      },
    );

    on<DecrementEvent>(
      (event, emit) {
        emit(state - 1);
      },
    );
  }
}