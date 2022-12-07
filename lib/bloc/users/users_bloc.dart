import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  UsersBloc() : super(UsersInitial()) {
    on<UsersEvent>((event, emit) {});
    on<DeletingUserEvent>((event, emit) {
      emit(DeletingUserState());
    });
    on<CompleteDeletingUserEvent>((event, emit) {
      emit(CompleteDeletingUserState());
    });
    on<FailedDeletingUserEvent>((event, emit) {
      emit(FailedDeletingUserState(error: event.error));
    });
    on<UpdatingUserEvent>((event, emit) {
      emit(UpdatingUserState());
    });
    on<CompleteUpdatingUserEvent>((event, emit) {
      emit(CompleteUpdatingUserState());
    });
    on<FailedUpdatingUserEvent>((event, emit) {
      emit(FailedUpdatingUserState(error: event.error));
    });
  }

  deleteUsers(String uid) async {
    add(DeletingUserEvent());
    try {
      DocumentReference users =
          FirebaseFirestore.instance.collection("users").doc(uid);

      await users.delete();
      add(CompleteDeletingUserEvent());
    } on FirebaseException catch (e) {
      add(FailedDeletingUserEvent(error: e.message!));
    }
  }

  updateUserInfo(
    String uid,
    String fullname,
    String phone,
    String address,
    String role,
  ) async {
    try {
      add(UpdatingUserEvent());
      DocumentReference users =
          FirebaseFirestore.instance.collection("users").doc(uid);
      await users.update({
        "fullname": fullname,
        "phone": phone,
        "address": address,
      });
      if (role.isNotEmpty) {
        await users.update(
          {
            "role": role,
          },
        );
      }
      add(CompleteUpdatingUserEvent());
    } on FirebaseException catch (e) {
      add(
        FailedUpdatingUserEvent(error: e.message!),
      );
    }
  }
}
