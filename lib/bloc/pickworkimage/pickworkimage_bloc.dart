import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

part 'pickworkimage_event.dart';
part 'pickworkimage_state.dart';

class PickworkimageBloc
    extends Bloc<PickWorkImageEvent, PickWorkImagemageState> {
  PickworkimageBloc() : super(PickWorkImagemageState()) {
    on<PickWorkImageEvent>((event, emit) {});
  }
}
