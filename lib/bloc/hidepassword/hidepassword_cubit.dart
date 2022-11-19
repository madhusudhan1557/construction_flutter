import 'package:bloc/bloc.dart';

part 'hidepassword_state.dart';

class HidepasswordCubit extends Cubit<HidepasswordState> {
  HidepasswordCubit() : super(HidepasswordState(hidepassword: true));

  void hidepassword(bool hidepassword) {
    emit(HidepasswordState(hidepassword: !hidepassword));
  }
}
