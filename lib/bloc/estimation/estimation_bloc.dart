import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'estimation_event.dart';
part 'estimation_state.dart';

class EstimationBloc extends Bloc<EstimationEvent, EstimationState> {
  EstimationBloc() : super(EstimationInitial()) {
    on<EstimationEvent>((event, emit) {});
  }
}
