part of 'counter_bloc.dart';

@immutable
abstract class CounterState {}

class CounterInitial extends CounterState {}

class IncrementState extends CounterState {}

class DecrementState extends CounterState {}
