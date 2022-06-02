import 'dart:developer';

import 'package:contact_ui/core/repo/repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  ContactRepo repo = ContactRepo();
  Future getJsonData() async {
    try {
      emit(AppLoading());
      log('e');
      var data = await repo.getContacts();
      if (data != null) {
        log('girdi1');
        //log(data[4]['login']);
        emit(AppSuccess(data: data));
      }
    } catch (e) {
      log('hatala girdi');
      emit(AppFailed(error: e.toString()));
    }
  }
}
