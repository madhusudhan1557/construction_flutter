part of 'sites_bloc.dart';

@immutable
abstract class SitesEvent {}

class FailedSiteEvent extends SitesEvent {
  final String? error;
  FailedSiteEvent({this.error});
}

class AddedSiteEvent extends SitesEvent {
  final String? message;
  AddedSiteEvent({this.message});
}

class CompletedSiteEvent extends SitesEvent {
  final List<dynamic>? sites;
  CompletedSiteEvent({this.sites});
}

class LoadingSiteEvent extends SitesEvent {}

class LoadingCompleteEvent extends SitesEvent {}

class SiteDataEvent extends SitesEvent {
  final Map<String, dynamic>? siteData;
  SiteDataEvent({this.siteData});
}

class SiteImagesEvent extends SitesEvent {
  final List<dynamic>? siteImages;
  SiteImagesEvent({this.siteImages});
}
