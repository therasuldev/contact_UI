import 'package:contact_ui/core/bloc/app_cubit.dart';
import 'package:contact_ui/locator.dart';
import 'package:contact_ui/view/page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

void main() async {
  await setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => GetIt.I.get<AppCubit>()..getALlUsers()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          floatingActionButtonTheme:
              FloatingActionButtonThemeData(backgroundColor: Colors.cyan[200]),
        ),
        home: const HomePage(),
      ),
    );
  }
}
