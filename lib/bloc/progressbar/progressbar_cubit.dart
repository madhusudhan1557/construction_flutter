import 'package:bloc/bloc.dart';

part 'progressbar_state.dart';

class ProgressbarCubit extends Cubit<ProgressbarState> {
  ProgressbarCubit() : super(ProgressbarState(progress: 0));
}
