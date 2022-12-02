part of 'stocks_bloc.dart';

@immutable
abstract class StocksState {}

class StocksInitial extends StocksState {}

class AddingSiteStockState extends StocksState {}

class CompletedAddingSiteStockState extends StocksState {}

class FailedSiteStockState extends StocksState {
  final String? error;
  FailedSiteStockState({this.error});
}

class UpdatingStockQuantityState extends StocksState {}

class CompleteUpdatingStockQuantityState extends StocksState {}

class FailedUpdatingStockQuantityState extends StocksState {
  final String? error;
  FailedUpdatingStockQuantityState({this.error});
}
