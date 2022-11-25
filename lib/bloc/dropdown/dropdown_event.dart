part of 'dropdown_bloc.dart';

@immutable
abstract class DropdownEvent {}

class DropdownSelectEvent extends DropdownEvent {
  final String? value;
  DropdownSelectEvent({this.value});
}
