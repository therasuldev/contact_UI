import 'package:contact_ui/core/repo/repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  ContactRepo repo = ContactRepo();
  Future getJsonData() async {
    try {
      emit(AppLoading());
      var data = await repo.getContacts();
      if (data != null) {
        emit(AppSuccess(data: data));
      }
    } catch (e) {
      emit(AppFailed(error: e.toString()));
    }
  }
}
