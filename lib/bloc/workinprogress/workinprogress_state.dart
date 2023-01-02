part of 'workinprogress_bloc.dart';

@immutable
abstract class WorkinprogressState {}

class WorkinprogressInitial extends WorkinprogressState {}

class AddingWorkState extends WorkinprogressState {}

class CompletedAddingWorkState extends WorkinprogressState {}

class FailedAddingWorkState extends WorkinprogressState {
  final String? error;
  FailedAddingWorkState({this.error});
}

class UpdatingWorkProgressState extends WorkinprogressState {}

class CompleteUpdatingWorkProgressState extends WorkinprogressState {}

class FailedUpdatingWorkProgressState extends WorkinprogressState {
  final String? error;
  FailedUpdatingWorkProgressState({this.error});
}

class UpdatingWorkInfoState extends WorkinprogressState {}

class CompleteUpdatingWorkInfoState extends WorkinprogressState {}

class FailedUpdatingWorkInfoState extends WorkinprogressState {
  final String? error;
  FailedUpdatingWorkInfoState({this.error});
}

class FailedDeletingWorkProgressState extends WorkinprogressState {
  final String? error;
  FailedDeletingWorkProgressState({this.error});
}

class DeletingWorkInfoState extends WorkinprogressState {}

class CompleteDeletingWorkInfoState extends WorkinprogressState {}

class FailedUploadingWorkImagesState extends WorkinprogressState {
  final String? error;
  FailedUploadingWorkImagesState({this.error});
}

class UploadingWorkImagesState extends WorkinprogressState {}

class CompletedUploadingWorkImagesState extends WorkinprogressState {}

class DeletingWorkImagesState extends WorkinprogressState {}

class FailedDeletingWorkImagesState extends WorkinprogressState {
  final String? error;
  FailedDeletingWorkImagesState({this.error});
}

class CompletedDeletingWorkImagesState extends WorkinprogressState {}
