import 'package:contact_ui/core/bloc/app_cubit.dart';
import 'package:get_it/get_it.dart';

import 'core/repo/repo.dart';

GetIt dl = GetIt.instance;

setup() async {
  dl.registerFactory(() => AppCubit());

  dl.registerLazySingleton(() => ContactRepo());
}
