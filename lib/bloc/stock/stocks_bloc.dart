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
  }

  addStock(StockModel stockModel, String sid) async {
    try {
      add(AddingSiteStockEvent());
      CollectionReference sitestock = FirebaseFirestore.instance
          .collection("sites")
          .doc(sid)
          .collection("stocks");

      await sitestock.add({
        "sid": sid,
        "skid": sitestock.doc().id,
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
}
