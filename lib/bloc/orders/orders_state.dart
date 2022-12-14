part of 'orders_bloc.dart';

@immutable
abstract class OrdersState {}

class OrdersInitial extends OrdersState {}

class AddingSiteOrderState extends OrdersState {}

class CompletedAddingSiteOrderState extends OrdersState {}

class FailedSiteOrderState extends OrdersState {
  final String? error;
  FailedSiteOrderState({this.error});
}

class UpdatingOrderQuantityState extends OrdersState {}

class CompleteUpdatingOrderQuantityState extends OrdersState {}

class FailedUpdatingOrderQuantityState extends OrdersState {
  final String? error;
  FailedUpdatingOrderQuantityState({this.error});
}

class DeletingOrderState extends OrdersState {}

class CompleteDeletingOrderState extends OrdersState {}

class FailedDeletingOrderState extends OrdersState {
  final String? error;
  FailedDeletingOrderState({this.error});
}

class UpdatingSiteOrderState extends OrdersState {}

class CompleteUpdatingSiteOrderState extends OrdersState {}

class FailedUpdatingSiteOrderState extends OrdersState {
  final String? error;
  FailedUpdatingSiteOrderState({this.error});
}

class UpdatingQuantityState extends OrdersState {}

class CompleteUpdatingQuantityState extends OrdersState {}

class FailedUpdatingQuantityState extends OrdersState {
  final String? error;
  FailedUpdatingQuantityState({this.error});
}
