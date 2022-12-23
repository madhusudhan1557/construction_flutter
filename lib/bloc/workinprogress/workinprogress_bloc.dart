import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:construction/data/models/works.dart';

import 'package:flutter/material.dart';

part 'workinprogress_event.dart';
part 'workinprogress_state.dart';

class WorkinprogressBloc
    extends Bloc<WorkinprogressEvent, WorkinprogressState> {
  WorkinprogressBloc() : super(WorkinprogressInitial()) {
    on<WorkinprogressEvent>((event, emit) {});
    on<AddingWorkEvent>(
      (event, emit) {
        emit(AddingWorkState());
      },
    );
    on<CompletedAddingWorkEvent>(
      (event, emit) {
        emit(CompletedAddingWorkState());
      },
    );
    on<FailedAddingWorkEvent>(
      (event, emit) {
        emit(FailedAddingWorkState(error: event.error));
      },
    );
    on<CompleteUpdatingWorkProgressEvent>(
      (event, emit) {
        emit(CompleteUpdatingWorkProgressState());
      },
    );
    on<UpdatingWorkProgressEvent>(
      (event, emit) {
        emit(UpdatingWorkProgressState());
      },
    );
    on<FailedUpdatingWorkProgressEvent>(
      (event, emit) {
        emit(FailedUpdatingWorkProgressState(error: event.error));
      },
    );
    on<CompleteUpdatingWorkInfoEvent>(
      (event, emit) {
        emit(CompleteUpdatingWorkInfoState());
      },
    );
    on<UpdatingWorkInfoEvent>(
      (event, emit) {
        emit(UpdatingWorkInfoState());
      },
    );
    on<FailedUpdatingWorkInfoEvent>(
      (event, emit) {
        emit(FailedUpdatingWorkInfoState(error: event.error));
      },
    );
    on<CompleteDeletingWorkInfoEvent>(
      (event, emit) {
        emit(CompleteDeletingWorkInfoState());
      },
    );
    on<DeletingWorkInfoEvent>(
      (event, emit) {
        emit(DeletingWorkInfoState());
      },
    );
    on<FailedDeletingWorkProgressEvent>(
      (event, emit) {
        emit(FailedDeletingWorkProgressState(error: event.error));
      },
    );
  }

  deleteWork(String sid, String wid) async {
    add(DeletingWorkInfoEvent());
    try {
      DocumentReference works = FirebaseFirestore.instance
          .collection('sites')
          .doc(sid)
          .collection("works")
          .doc(wid);
      await works.delete();
      add(CompleteDeletingWorkInfoEvent());
    } on FirebaseException catch (e) {
      add(FailedDeletingWorkProgressEvent(error: e.message!));
    }
  }

  addWork(WorksModel worksModel, String sid) async {
    add(AddingWorkEvent());
    try {
      CollectionReference works = FirebaseFirestore.instance
          .collection('sites')
          .doc(sid)
          .collection("works");
      String wid = works.doc().id;
      works.doc(wid).set({
        "sid": sid,
        "wid": wid,
        "title": worksModel.title,
        "startdate": worksModel.startdate,
        "endDate": worksModel.endDate,
        "workdesc": worksModel.workdesc,
        "progress": num.parse("0.0"),
      });
      add(CompletedAddingWorkEvent());
    } on FirebaseException catch (e) {
      add(FailedAddingWorkEvent(error: e.message));
    }
  }

  updateWorkProgress(double progress, String wid, String sid) async {
    try {
      add(UpdatingWorkProgressEvent());
      DocumentReference workDoc = FirebaseFirestore.instance
          .collection("sites")
          .doc(sid)
          .collection("works")
          .doc(wid);
      await workDoc.update({
        "progress": progress,
      });
      add(CompleteUpdatingWorkProgressEvent());
    } on FirebaseException catch (e) {
      add(
        FailedUpdatingWorkProgressEvent(error: e.message!),
      );
    }
  }

  updateWorkInfo(WorksModel worksModel, String sid) async {
    try {
      add(UpdatingWorkInfoEvent());
      DocumentReference workDoc = FirebaseFirestore.instance
          .collection("sites")
          .doc(sid)
          .collection("works")
          .doc(worksModel.wid);
      await workDoc.update({
        "title": worksModel.title,
        "startdate": worksModel.startdate,
        "endDate": worksModel.endDate,
      });
      if (worksModel.workdesc != null) {
        await workDoc.update({
          "workdesc": worksModel.workdesc,
        });
      }
      add(CompleteUpdatingWorkInfoEvent());
    } on FirebaseException catch (e) {
      add(
        FailedUpdatingWorkInfoEvent(error: e.message!),
      );
    }
  }
}
