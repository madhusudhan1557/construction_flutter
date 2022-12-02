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
