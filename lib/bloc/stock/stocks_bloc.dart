import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:construction/data/models/stocks.dart';
import 'package:flutter/material.dart';

part 'stocks_event.dart';
part 'stocks_state.dart';

class StocksBloc extends Bloc<StocksEvent, StocksState> {
  StocksBloc() : super(StocksInitial()) {
    on<StocksEvent>((event, emit) {});
    on<AddingSiteStockEvent>(
      (event, emit) {
        emit(AddingSiteStockState());
      },
    );
    on<CompletedAddingSiteStockEvent>(
      (event, emit) {
        emit(CompletedAddingSiteStockState());
      },
    );
    on<FailedSiteStockEvent>(
      (event, emit) {
        emit(FailedSiteStockState(error: event.error));
      },
    );
    on<CompleteUpdatingStockQuantityEvent>(
      (event, emit) {
        emit(CompleteUpdatingStockQuantityState());
      },
    );
    on<UpdatingStockQuantityEvent>(
      (event, emit) {
        emit(UpdatingStockQuantityState());
      },
    );
    on<FailedUpdatingStockQuantityEvent>(
      (event, emit) {
        emit(FailedUpdatingStockQuantityState(error: event.error));
      },
    );
  }

  addStock(StockModel stockModel, String sid) async {
    try {
      add(AddingSiteStockEvent());
      CollectionReference sitestock = FirebaseFirestore.instance
          .collection("sites")
          .doc(sid)
          .collection("stocks");
      String skid = sitestock.doc().id;
      await sitestock.doc(skid).set({
        "sid": sid,
        "skid": skid,
        "itemname": stockModel.itemname,
        "brandname": stockModel.brandname,
        "suppliername": stockModel.suppliername,
        "unit": stockModel.unit,
        "quantity": stockModel.quantity,
        "rate": stockModel.rate,
      });
      add(CompletedAddingSiteStockEvent());
    } on FirebaseException catch (e) {
      add(FailedSiteStockEvent(error: e.message!));
    }
  }

  updateStockQuantity(String sid, double quantity, String skid) async {
    try {
      add(UpdatingStockQuantityEvent());
      double qty = 0;
      QuerySnapshot workDoc = await FirebaseFirestore.instance
          .collection("sites")
          .doc(sid)
          .collection("stocks")
          .where("skid", isEqualTo: skid)
          .get();
      for (QueryDocumentSnapshot<Object?> element in workDoc.docs) {
        qty = element['quantity'] - quantity;
      }
      if (qty.isNegative) {
        add(
          FailedUpdatingStockQuantityEvent(
              error: "Stock used is greater than available quantity"),
        );
      } else {
        DocumentReference workDoc = FirebaseFirestore.instance
            .collection("sites")
            .doc(sid)
            .collection("stocks")
            .doc(skid);
        await workDoc.update({
          "quantity": qty,
        });
        add(CompleteUpdatingStockQuantityEvent());
      }
    } on FirebaseException catch (e) {
      add(FailedUpdatingStockQuantityEvent(error: e.message!));
    }
  }
}
