part of 'pickimage_bloc.dart';

@immutable
class PickimageEvent {}

class OnSelectImage extends PickimageEvent {
  final List<XFile>? siteimage;
  OnSelectImage({this.siteimage});
}
