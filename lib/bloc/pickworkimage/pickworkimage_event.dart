part of 'pickworkimage_bloc.dart';

@immutable
class PickWorkImageEvent {}

class OnSelectImage extends PickWorkImageEvent {
  final List<XFile>? workimages;
  OnSelectImage({this.workimages});
}
