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
