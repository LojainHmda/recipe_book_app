import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_book_app/cubit/is_fav_states.dart';

class IsFavCubit extends Cubit<IsFavStates> {
  IsFavCubit() : super(NotFav());

  isFav() {
    emit(IsFav());
  }

  isNotFav() {
    emit(NotFav());
  }
}
