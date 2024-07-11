import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:qr_absensi/data/datasources/api_data_source.dart';
import 'package:qr_absensi/data/repositories/api_repo_impl.dart';
import 'package:qr_absensi/domain/repositories/api_repository.dart';
import 'package:qr_absensi/domain/usecases/do_login.dart';
import 'package:qr_absensi/domain/usecases/do_register.dart';
import 'package:qr_absensi/domain/usecases/get_istilah.dart';
import 'package:qr_absensi/presentation/providers/home_provider.dart';
import 'package:qr_absensi/presentation/providers/login_provider.dart';
import 'package:qr_absensi/presentation/providers/register_provider.dart';
import 'package:qr_absensi/utility/session_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dio_client.dart';

final locator = GetIt.instance;

Future<void> init() async {
  locator.registerLazySingleton<GlobalKey<NavigatorState>>(
      () => GlobalKey<NavigatorState>());
  locator.registerLazySingleton<Dio>(() => DioClient().dio);
  locator.registerLazySingletonAsync<Session>(() async =>
      SessionHelper(pref: await locator.getAsync<SharedPreferences>()));
  locator.registerLazySingletonAsync<SharedPreferences>(
      () async => await SharedPreferences.getInstance());

//Datasource
  locator.registerLazySingleton<ApiDataSource>(
      () => ApiDataSourceImplementation(dio: locator()));

//Repository
  locator.registerLazySingleton<ApiRepository>(
      () => ApiRepoImpl(dataSource: locator()));

  //Usecase
  locator.registerLazySingleton<DoLogin>(
      () => DoLogin(repository: locator(), session: locator()));
  locator.registerLazySingleton<DoRegister>(
      () => DoRegister(repository: locator()));
  locator.registerLazySingleton<GetIstilah>(
      () => GetIstilah(repository: locator()));

  //Providers
  locator
      .registerFactory<LoginProvider>(() => LoginProvider(doLogin: locator()));
  locator.registerFactory<RegisterProvider>(
      () => RegisterProvider(doRegister: locator()));
  locator.registerFactory<HomeProvider>(() => HomeProvider(doLogin: locator()));
}
