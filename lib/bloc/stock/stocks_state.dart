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

class DeletingStockState extends StocksState {}

class CompleteDeletingStockState extends StocksState {}

class FailedDeletingStockState extends StocksState {
  final String? error;
  FailedDeletingStockState({this.error});
}

class UpdatingSiteStockState extends StocksState {}

class CompleteUpdatingSiteStockState extends StocksState {}

class FailedUpdatingSiteStockState extends StocksState {
  final String? error;
  FailedUpdatingSiteStockState({this.error});
}

class UpdatingQuantityState extends StocksState {}

class CompleteUpdatingQuantityState extends StocksState {}

class FailedUpdatingQuantityState extends StocksState {
  final String? error;
  FailedUpdatingQuantityState({this.error});
}
