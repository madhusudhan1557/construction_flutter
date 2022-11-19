part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class LoginLoadingEvent extends AuthEvent {}

class LoginFailedEvent extends AuthEvent {
  final String error;
  LoginFailedEvent({required this.error});
}

class LoginCodeSentEvent extends AuthEvent {}

class LoggedInEvent extends AuthEvent {
  final User firebaseUser;
  LoggedInEvent({required this.firebaseUser});
}

class LoggedOutEvent extends AuthEvent {}

class NewUserCreatedEvent extends AuthEvent {
  final User firebaseUser;
  NewUserCreatedEvent({required this.firebaseUser});
}
