part of 'dropdown_bloc.dart';

@immutable
abstract class DropdownState {}

class DropdownInitial extends DropdownState {}

class DropdownSelectState extends DropdownState {
  final String? value;
  DropdownSelectState({this.value});
}
