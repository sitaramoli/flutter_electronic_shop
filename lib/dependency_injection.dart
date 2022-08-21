import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:electronic_shop/app/app_prefs.dart';
import 'package:electronic_shop/app/check_connection/connection_status.dart';
import 'package:electronic_shop/features/authentication/data/data_sources/remote_data_source.dart';
import 'package:electronic_shop/features/authentication/data/repo/auth_repo.dart';
import 'package:electronic_shop/features/authentication/domain/repo/i_auth_repo.dart';
import 'package:electronic_shop/features/authentication/domain/usecases/email_login.dart';
import 'package:electronic_shop/features/authentication/domain/usecases/google_login.dart';
import 'package:electronic_shop/features/authentication/domain/usecases/logout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/authentication/presentation/login/login_view_model.dart';

final instance = GetIt.instance;

Future<void> init() async {
  //view model
  instance.registerFactory<LoginViewModel>(() => LoginViewModel(
      emailLoginUsecase: instance.call(),
      connectionStatus: instance.call(),
      logoutUsecase: instance.call(),
      appPrefs: instance.call(),
      googleLoginUsecase: instance.call()));

  //usecase
  //auth use case
  instance.registerLazySingleton<EmailLoginUsecase>(
      () => EmailLoginUsecase(instance.call()));
  instance.registerLazySingleton<GoogleLoginUsecase>(
      () => GoogleLoginUsecase(instance.call()));
  instance.registerLazySingleton<LogoutUsecase>(
      () => LogoutUsecase(authRepo: instance.call()));

  //repo
  //auth repo
  instance.registerLazySingleton<IAuthRepo>(() =>
      AuthRepo(remoteDataSource: instance.call(), appPrefs: instance.call()));

  //data source
  //auth data source
  instance.registerLazySingleton<IAuthRemoteDataSource>(
      () => AuthRemoteDataSource(firebaseAuth: instance.call()));

  //external
  // firebase auth
  instance.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  // shared preferences
  final prefs = await SharedPreferences.getInstance();
  instance.registerLazySingleton<AppPrefs>(() => AppPrefs(prefs));
  // connection status
  instance.registerLazySingleton<ConnectionStatus>(
      () => ConnectionStatus(Connectivity()));
}
