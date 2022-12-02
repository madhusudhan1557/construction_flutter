import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'dropdown_event.dart';
part 'dropdown_state.dart';

class DropdownBloc extends Bloc<DropdownEvent, DropdownState> {
  DropdownBloc() : super(DropdownInitial()) {
    on<DropdownEvent>((event, emit) {});
    on<DropdownUserSelectEvent>((event, emit) {
      emit(DropdownUserSelectState(value: event.value));
    });
    on<DropdownItemSelectEvent>((event, emit) {
      emit(DropdownItemSelectState(value: event.value));
    });
    on<DropdownSiteSelectEvent>((event, emit) {
      emit(DropdownSiteSelectState(value: event.value));
    });
  }

  onUserSelectDropdown(String value) async {
    add(DropdownUserSelectEvent(value: value));
  }

  onItemSelectDropdown(String value) async {
    add(DropdownItemSelectEvent(value: value));
  }

  onSiteSelectDropdown(String value) async {
    add(DropdownSiteSelectEvent(value: value));
  }
}
