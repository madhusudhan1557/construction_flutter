part of 'users_bloc.dart';

@immutable
abstract class UsersState {}

class UsersInitial extends UsersState {}

class DeletingUserState extends UsersState {}

class CompleteDeletingUserState extends UsersState {}

class FailedDeletingUserState extends UsersState {
  final String? error;
  FailedDeletingUserState({this.error});
}

class UpdatingUserState extends UsersState {}

class CompleteUpdatingUserState extends UsersState {}

class FailedUpdatingUserState extends UsersState {
  final String? error;
  FailedUpdatingUserState({this.error});
}
