part of 'workinprogress_bloc.dart';

@immutable
abstract class WorkinprogressEvent {}

class AddingWorkEvent extends WorkinprogressEvent {}

class CompletedAddingWorkEvent extends WorkinprogressEvent {}

class FailedAddingWorkEvent extends WorkinprogressEvent {
  final String? error;
  FailedAddingWorkEvent({this.error});
}

class UpdatingWorkProgressEvent extends WorkinprogressEvent {}

class CompleteUpdatingWorkProgressEvent extends WorkinprogressEvent {}

class FailedUpdatingWorkProgressEvent extends WorkinprogressEvent {
  final String? error;
  FailedUpdatingWorkProgressEvent({this.error});
}

class UpdatingWorkInfoEvent extends WorkinprogressEvent {}

class CompleteUpdatingWorkInfoEvent extends WorkinprogressEvent {}

class FailedUpdatingWorkInfoEvent extends WorkinprogressEvent {
  final String? error;
  FailedUpdatingWorkInfoEvent({this.error});
}
