part of 'users_bloc.dart';

@immutable
abstract class UsersEvent {}

class DeletingUserEvent extends UsersEvent {}

class CompleteDeletingUserEvent extends UsersEvent {}

class FailedDeletingUserEvent extends UsersEvent {
  final String? error;
  FailedDeletingUserEvent({this.error});
}

class UpdatingUserEvent extends UsersEvent {}

class CompleteUpdatingUserEvent extends UsersEvent {}

class FailedUpdatingUserEvent extends UsersEvent {
  final String? error;
  FailedUpdatingUserEvent({this.error});
}
