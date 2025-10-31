import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'check_box_state.dart';

class CheckBoxCubit extends Cubit<CheckBoxState> {
  CheckBoxCubit() : super(UnChecked());

  bool flag = false;

  check() {
    flag = !flag;
    if (flag) {
      emit(Checked());
    } else {
      emit(UnChecked());
    }
  }
}
