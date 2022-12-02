part of 'dropdown_bloc.dart';

@immutable
abstract class DropdownState {}

class DropdownInitial extends DropdownState {}

class DropdownUserSelectState extends DropdownState {
  final String? value;
  DropdownUserSelectState({this.value});
}

class DropdownItemSelectState extends DropdownState {
  final String? value;
  DropdownItemSelectState({this.value});
}

class DropdownSiteSelectState extends DropdownState {
  final String? value;
  DropdownSiteSelectState({this.value});
}
