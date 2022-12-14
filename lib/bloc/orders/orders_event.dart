part of 'orders_bloc.dart';

@immutable
abstract class OrdersEvent {}

class AddingSiteOrderEvent extends OrdersEvent {}

class CompletedAddingSiteOrderEvent extends OrdersEvent {}

class FailedSiteOrderEvent extends OrdersEvent {
  final String? error;
  FailedSiteOrderEvent({this.error});
}

class UpdatingOrderQuantityEvent extends OrdersEvent {}

class CompleteUpdatingOrderQuantityEvent extends OrdersEvent {}

class FailedUpdatingOrderQuantityEvent extends OrdersEvent {
  final String? error;
  FailedUpdatingOrderQuantityEvent({this.error});
}

class DeletingOrderEvent extends OrdersEvent {}

class CompleteDeletingOrderEvent extends OrdersEvent {}

class FailedDeletingOrderEvent extends OrdersEvent {
  final String? error;
  FailedDeletingOrderEvent({this.error});
}

class UpdatingSiteOrderEvent extends OrdersEvent {}

class CompleteUpdatingSiteOrderEvent extends OrdersEvent {}

class FailedUpdatingSiteOrderEvent extends OrdersEvent {
  final String? error;
  FailedUpdatingSiteOrderEvent({this.error});
}

class UpdatingQuantityEvent extends OrdersEvent {}

class CompleteUpdatingQuantityEvent extends OrdersEvent {}

class FailedUpdatingQuantityEvent extends OrdersEvent {
  final String? error;
  FailedUpdatingQuantityEvent({this.error});
}
