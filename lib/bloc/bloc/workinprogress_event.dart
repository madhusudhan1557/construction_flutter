part of 'workinprogress_bloc.dart';

@immutable
abstract class WorkinprogressEvent {}

class AddingWorkEvent extends WorkinprogressEvent {}

class CompletedAddingWorkEvent extends WorkinprogressEvent {}

class FailedAddingWorkEvent extends WorkinprogressEvent {
  final String? error;
  FailedAddingWorkEvent({this.error});
}
