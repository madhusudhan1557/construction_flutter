import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import 'package:image_picker/image_picker.dart';

part 'pickimage_event.dart';
part 'pickimage_state.dart';

class PickimageBloc extends Bloc<PickimageEvent, PickimageState> {
  PickimageBloc() : super(PickimageState()) {
    on<PickimageEvent>((event, emit) {});
    on<OnSelectImage>(
      (event, emit) {
        emit(PickimageState(siteimage: event.siteimage));
      },
    );
  }

  pickImage(List<XFile> siteimage) async {
    add(OnSelectImage(siteimage: siteimage));
  }

  removeImage(List<XFile> siteimage, index) async {
    siteimage.removeAt(index);
  }
}
