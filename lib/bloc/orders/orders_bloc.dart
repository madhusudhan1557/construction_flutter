import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../data/models/order_model.dart';

part 'orders_event.dart';
part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  OrdersBloc() : super(OrdersInitial()) {
    on<OrdersEvent>((event, emit) {});
    on<AddingSiteOrderEvent>(
      (event, emit) {
        emit(AddingSiteOrderState());
      },
    );
    on<CompletedAddingSiteOrderEvent>(
      (event, emit) {
        emit(CompletedAddingSiteOrderState());
      },
    );
    on<FailedSiteOrderEvent>(
      (event, emit) {
        emit(FailedSiteOrderState(error: event.error));
      },
    );
    on<CompleteUpdatingOrderQuantityEvent>(
      (event, emit) {
        emit(CompleteUpdatingOrderQuantityState());
      },
    );
    on<UpdatingOrderQuantityEvent>(
      (event, emit) {
        emit(UpdatingOrderQuantityState());
      },
    );
    on<FailedUpdatingOrderQuantityEvent>(
      (event, emit) {
        emit(FailedUpdatingOrderQuantityState(error: event.error));
      },
    );
    on<FailedDeletingOrderEvent>(
      (event, emit) {
        emit(FailedDeletingOrderState(error: event.error));
      },
    );
    on<DeletingOrderEvent>(
      (event, emit) {
        emit(DeletingOrderState());
      },
    );
    on<CompleteDeletingOrderEvent>(
      (event, emit) {
        emit(CompleteDeletingOrderState());
      },
    );
    on<CompleteUpdatingSiteOrderEvent>(
      (event, emit) {
        emit(CompleteUpdatingSiteOrderState());
      },
    );
    on<UpdatingSiteOrderEvent>(
      (event, emit) {
        emit(UpdatingSiteOrderState());
      },
    );
    on<FailedUpdatingSiteOrderEvent>(
      (event, emit) {
        emit(FailedUpdatingSiteOrderState(error: event.error));
      },
    );
    on<CompleteUpdatingQuantityEvent>(
      (event, emit) {
        emit(CompleteUpdatingQuantityState());
      },
    );
    on<UpdatingQuantityEvent>(
      (event, emit) {
        emit(UpdatingQuantityState());
      },
    );
    on<FailedUpdatingQuantityEvent>(
      (event, emit) {
        emit(FailedUpdatingQuantityState(error: event.error));
      },
    );
  }

  addOrder(OrderModel orderModel, String sid) async {
    try {
      add(AddingSiteOrderEvent());
      CollectionReference siteOrder = FirebaseFirestore.instance
          .collection("sites")
          .doc(sid)
          .collection("orders");
      String oid = siteOrder.doc().id;
      await siteOrder.doc(oid).set({
        "sid": sid,
        "oid": oid,
        "itemname": orderModel.itemname,
        "brandname": orderModel.brandname,
        "suppliername": orderModel.suppliername,
        "unit": orderModel.unit,
        "quantity": orderModel.quantity,
        "status": "On The Way",
        "rate": orderModel.rate,
      });
      add(CompletedAddingSiteOrderEvent());
    } on FirebaseException catch (e) {
      add(FailedSiteOrderEvent(error: e.message!));
    }
  }

  updateOrderQuantity(String sid, double quantity, String oid) async {
    try {
      add(UpdatingOrderQuantityEvent());
      double qty = 0;
      QuerySnapshot orderdoc = await FirebaseFirestore.instance
          .collection("sites")
          .doc(sid)
          .collection("orders")
          .where("oid", isEqualTo: oid)
          .get();
      for (QueryDocumentSnapshot<Object?> element in orderdoc.docs) {
        qty = element['quantity'] - quantity;
      }
      if (qty.isNegative) {
        add(
          FailedUpdatingOrderQuantityEvent(
              error: "Order used is greater than available quantity"),
        );
      } else {
        DocumentReference orderdoc = FirebaseFirestore.instance
            .collection("sites")
            .doc(sid)
            .collection("orders")
            .doc(oid);
        await orderdoc.update({
          "quantity": qty,
        });
        add(CompleteUpdatingOrderQuantityEvent());
      }
    } on FirebaseException catch (e) {
      add(FailedUpdatingOrderQuantityEvent(error: e.message!));
    }
  }

  addOrderQuantity(String sid, String oid, double quantity) async {
    try {
      add(UpdatingQuantityEvent());
      double qty = 0;
      QuerySnapshot orderDocs = await FirebaseFirestore.instance
          .collection("sites")
          .doc(sid)
          .collection("orders")
          .where("oid", isEqualTo: oid)
          .get();
      for (QueryDocumentSnapshot<Object?> element in orderDocs.docs) {
        qty = element['quantity'] + quantity;
      }

      DocumentReference orderdoc = FirebaseFirestore.instance
          .collection("sites")
          .doc(sid)
          .collection("orders")
          .doc(oid);
      await orderdoc.update({
        "quantity": qty,
      });
      add(CompleteUpdatingQuantityEvent());
    } on FirebaseException catch (e) {
      add(FailedUpdatingQuantityEvent(error: e.message!));
    }
  }

  updateSiteOrder(
      String sid,
      String oid,
      String itemname,
      String suppliername,
      String itembrand,
      double quantity,
      String status,
      double rate,
      String unit) async {
    try {
      add(UpdatingSiteOrderEvent());
      DocumentReference ordersDoc = FirebaseFirestore.instance
          .collection("sites")
          .doc(sid)
          .collection("orders")
          .doc(oid);
      await ordersDoc.update({
        "itemname": itemname,
        "brandname": itembrand,
        "suppliername": suppliername,
        "quantity": quantity,
        "rate": rate,
        "unit": unit,
      });
      if (status.isNotEmpty) {
        await ordersDoc.update({
          "status": status,
        });
      }

      if (status == "Delivered") {
        CollectionReference sitesStock = FirebaseFirestore.instance
            .collection("sites")
            .doc(sid)
            .collection("stocks");
        await sitesStock.doc(oid).set({
          "sid": sid,
          "skid": oid,
          "itemname": itemname,
          "brandname": itembrand,
          "suppliername": suppliername,
          "quantity": quantity,
          "rate": rate,
          "unit": unit,
        });
      }

      add(CompleteUpdatingSiteOrderEvent());
    } on FirebaseException catch (e) {
      add(FailedUpdatingSiteOrderEvent(error: e.message!));
    }
  }

  deleteSiteOrder(String sid, String oid) async {
    try {
      add(DeletingOrderEvent());
      DocumentReference orders = FirebaseFirestore.instance
          .collection("sites")
          .doc(sid)
          .collection("orders")
          .doc(oid);
      await orders.delete();
      add(CompleteDeletingOrderEvent());
    } on FirebaseException catch (e) {
      add(FailedDeletingOrderEvent(error: e.message!));
    }
  }
}
