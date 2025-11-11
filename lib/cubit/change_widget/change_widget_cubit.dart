import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'change_widget_state.dart';

class ChangeWidgetCubit extends Cubit<ChangeWidgetState> {
  ChangeWidgetCubit() : super(ChangeWidgetInitial());
  int mainIndex=0;
  refresh(int index) {
    mainIndex=index;
    emit(ChangeWidgetInitial());
  }
}
