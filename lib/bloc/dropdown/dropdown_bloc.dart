import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'dropdown_event.dart';
part 'dropdown_state.dart';

class DropdownBloc extends Bloc<DropdownEvent, DropdownState> {
  DropdownBloc() : super(DropdownInitial()) {
    on<DropdownEvent>((event, emit) {});
    on<DropdownSelectEvent>((event, emit) {
      emit(DropdownSelectState(value: event.value));
    });
  }

  onSelectDropdown(String value) async {
    add(DropdownSelectEvent(value: value));
  }
}
