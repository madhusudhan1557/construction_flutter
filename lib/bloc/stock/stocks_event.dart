part of 'stocks_bloc.dart';

@immutable
abstract class StocksEvent {}

class AddingSiteStockEvent extends StocksEvent {}

class CompletedAddingSiteStockEvent extends StocksEvent {}

class FailedSiteStockEvent extends StocksEvent {
  final String? error;
  FailedSiteStockEvent({this.error});
}
