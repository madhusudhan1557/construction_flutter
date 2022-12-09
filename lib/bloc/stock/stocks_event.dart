part of 'stocks_bloc.dart';

@immutable
abstract class StocksEvent {}

class AddingSiteStockEvent extends StocksEvent {}

class CompletedAddingSiteStockEvent extends StocksEvent {}

class FailedSiteStockEvent extends StocksEvent {
  final String? error;
  FailedSiteStockEvent({this.error});
}

class UpdatingStockQuantityEvent extends StocksEvent {}

class CompleteUpdatingStockQuantityEvent extends StocksEvent {}

class FailedUpdatingStockQuantityEvent extends StocksEvent {
  final String? error;
  FailedUpdatingStockQuantityEvent({this.error});
}

class DeletingStockEvent extends StocksEvent {}

class CompleteDeletingStockEvent extends StocksEvent {}

class FailedDeletingStockEvent extends StocksEvent {
  final String? error;
  FailedDeletingStockEvent({this.error});
}

class UpdatingSiteStockEvent extends StocksEvent {}

class CompleteUpdatingSiteStockEvent extends StocksEvent {}

class FailedUpdatingSiteStockEvent extends StocksEvent {
  final String? error;
  FailedUpdatingSiteStockEvent({this.error});
}

class UpdatingQuantityEvent extends StocksEvent {}

class CompleteUpdatingQuantityEvent extends StocksEvent {}

class FailedUpdatingQuantityEvent extends StocksEvent {
  final String? error;
  FailedUpdatingQuantityEvent({this.error});
}
