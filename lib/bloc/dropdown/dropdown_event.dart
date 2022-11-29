part of 'dropdown_bloc.dart';

@immutable
abstract class DropdownEvent {}

class DropdownUserSelectEvent extends DropdownEvent {
  final String? value;
  DropdownUserSelectEvent({this.value});
}

class DropdownItemSelectEvent extends DropdownEvent {
  final String? value;
  DropdownItemSelectEvent({this.value});
}
