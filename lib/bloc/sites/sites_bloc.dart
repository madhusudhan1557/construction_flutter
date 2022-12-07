import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/models/sites.dart';
import '../../data/models/stocks.dart';
import '../../main.dart';

part 'sites_event.dart';
part 'sites_state.dart';

class SitesBloc extends Bloc<SitesEvent, SitesState> {
  SitesBloc() : super(SitesInitial()) {
    on<SitesEvent>((event, emit) {});
    on<FailedSiteEvent>(
      (event, emit) => emit(
        FailedSiteState(error: event.error),
      ),
    );
    on<LoadingSiteEvent>(
      (event, emit) => emit(LoadingSiteState()),
    );
    on<LoadingCompleteEvent>(
      (event, emit) => emit(LoadingCompleteState()),
    );
    on<CompletedSiteEvent>(
      (event, emit) => emit(CompletedSiteState(sites: event.sites)),
    );
    on<AddedSiteEvent>(
      (event, emit) => emit(AddedSiteState(message: event.message)),
    );
    on<SiteDataEvent>(
      (event, emit) => emit(SiteDataState(siteData: event.siteData)),
    );
    on<SiteImagesEvent>(
      (event, emit) => emit(SiteImagesState(siteImages: event.siteImages)),
    );
    on<LoadingDeleteCompleteEvent>(
      (event, emit) => emit(LoadingCompleteState()),
    );
    on<LoadingDeleteSiteEvent>(
      (event, emit) => emit(LoadingDeleteSiteState()),
    );
    on<FailedDeleteSiteEvent>(
      (event, emit) => emit(FailedDeleteSiteState()),
    );
    on<UpdatingSiteEvent>(
      (event, emit) => emit(UpdatingSiteState()),
    );
    on<CompleteUpdatingSiteEvent>(
      (event, emit) => emit(CompleteUpdatingSiteState()),
    );
    on<FailedUpdatingSiteEvent>(
      (event, emit) => emit(FailedUpdatingSiteState()),
    );
  }

  CollectionReference sites = FirebaseFirestore.instance.collection("sites");
  String id = "";
  Future<void> addSite(SiteModel siteModel, List<XFile> images) async {
    add(LoadingSiteEvent());
    List<dynamic> imageUrls = [];
    id = sites.doc().id;
    try {
      await sites.doc(id).set({
        "sid": id,
        "sitename": siteModel.sitename,
        "sitedesc": siteModel.sitedesc,
        "sitelocation": siteModel.sitelocation,
        "clientname": siteModel.clientname,
        "phone": siteModel.phone,
        "supervisor": siteModel.supervisor,
      });

      for (int i = 0; i < images.length; i++) {
        var url = uploadFile(images[i]);
        imageUrls.add(url.toString());
      }

      add(CompletedSiteEvent());
    } on FirebaseException catch (e) {
      add(FailedSiteEvent(error: e.message));
    }
  }

  addSiteStock(StockModel stockModel, sid) async {
    add(LoadingSiteEvent());
    try {
      sites.doc(sid).collection("sitestocks").add({
        "sid": sid,
      });
    } on FirebaseException catch (e) {
      add(FailedSiteEvent(error: e.message));
    }
  }

  uploadFile(XFile image) async {
    Reference reference =
        FirebaseStorage.instance.ref().child("siteimages").child(image.name);
    UploadTask uploadTask = reference.putFile(File(image.path));
    await uploadTask.whenComplete(() async {
      sites.doc(id).collection("siteimages").add({
        "sid": id,
        "image": await reference.getDownloadURL(),
      });
    });
    return await reference.getDownloadURL();
  }

  Future<void> deleteSite(String sid, List<String> imageurl, context) async {
    final size = MediaQuery.of(context).size;
    try {
      BotToast.showCustomLoading(
        toastBuilder: (cancelFunc) {
          return customLoading(size);
        },
      );

      Future<QuerySnapshot> siteimages =
          sites.doc(sid).collection("siteimages").get();
      siteimages.then((value) {
        for (QueryDocumentSnapshot element in value.docs) {
          sites.doc(id).collection("siteimages").doc(element.id).delete();
        }
      });
      QuerySnapshot snapshot = await sites.where('sid', isEqualTo: sid).get();
      for (QueryDocumentSnapshot doc in snapshot.docs) {
        await doc.reference.delete();
      }
      for (String url in imageurl) {
        await FirebaseStorage.instance.refFromURL(url).delete();
      }

      BotToast.closeAllLoading();
      Navigator.of(context).pop();
      BotToast.closeAllLoading();
      BotToast.showText(
        text: "Site Deleted",
        contentColor: Colors.green,
      );
    } on FirebaseException catch (e) {
      BotToast.closeAllLoading();
      Navigator.of(context).pop();
      BotToast.showText(
        text: e.message!,
        contentColor: Colors.red,
      );
    }
  }

  updateSiteInfo({
    required String sid,
    required String sitename,
    required String sitelocation,
    required String clientname,
    required String phone,
    required String sitedesc,
    required String supervisor,
  }) async {
    try {
      add(UpdatingSiteEvent());
      DocumentReference sites =
          FirebaseFirestore.instance.collection("sites").doc(sid);

      await sites.update({
        "sitename": sitename,
        "sitelocation": sitelocation,
        "clientname": clientname,
        "phone": phone,
        "sitedesc": sitedesc,
      });

      if (supervisor.isNotEmpty) {
        await sites.update({"supervisor": supervisor});
      }
      add(CompleteUpdatingSiteEvent());
    } on FirebaseException catch (e) {
      add(FailedUpdatingSiteEvent(error: e.message!));
    }
  }
}
