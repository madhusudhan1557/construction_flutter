import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../data/models/sites.dart';

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
  }

  Future<void> addSite(SiteModel siteModel) async {}
}
