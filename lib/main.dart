import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:tsd/screens/home/cubit/home_cubit.dart';
import 'package:tsd/screens/packingList/cubit/packinglist_cubit.dart';
import 'package:tsd/screens/sscc/cubit/sscc_cubit.dart';
import 'app.dart';
import 'utils/authentication/authentication_service.dart';
import 'utils/authentication/bloc/authentication_bloc.dart';
import 'utils/moor/moor_database.dart';
import 'utils/repository.dart';

void main() {
  //Инициализация настроек
  Settings.init();

  //Moor db
  final db = AppDatabase();

  // Backend repo
  final DataRepository dataRepository = DataRepository(db);

  runApp(EasyLocalization(
    child: RepositoryProvider<AuthenticationService>(
        create: (context) {
          return UserAuthenticationService();
        },
        // Injects the Authentication BLoC
        child: MultiBlocProvider(
            providers: [
              BlocProvider<SsccCubit>(
                  create: (BuildContext context) => SsccCubit(dataRepository)),
              BlocProvider<PackinglistCubit>(
                  create: (BuildContext context) =>
                      PackinglistCubit(dataRepository)),
              BlocProvider<HomeCubit>(
                  create: (BuildContext context) =>
                      HomeCubit(dataRepository, db)),
              BlocProvider<AuthenticationBloc>(
                create: (context) {
                  final authService =
                      RepositoryProvider.of<AuthenticationService>(context);
                  return AuthenticationBloc(authService)..add(AppLoaded());
                },
              )
            ],
            child: App(
              
             
            ))),
    supportedLocales: [Locale('en', 'US'), Locale('ru', 'RU')],
    path: 'assets/translations',
    fallbackLocale: Locale('en', 'US'),
  ));
}


