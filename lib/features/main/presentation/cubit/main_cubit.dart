import 'package:flutter_bloc/flutter_bloc.dart';
import 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(const MainState(selectedIndex: 0));

  void selectTab(int index) {
    emit(MainState(selectedIndex: index));
  }
}
