import 'dart:developer';

import 'package:contact_ui/core/repo/repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppState.unknown());

  ContactRepo repo = ContactRepo();
  void getALlUsers() async {
    try {
      emit(AppState.loading());
      final user = await repo.getContacts();
      emit(AppState.success(data: user));
    } catch (e) {
      emit(AppState.failed());
    }
  }
}
