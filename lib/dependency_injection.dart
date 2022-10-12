import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:electronic_shop/app/core/network/network_info.dart';
import 'package:electronic_shop/features/authentication/login/data/data_sources/login_remote_data_source.dart';
import 'package:electronic_shop/features/authentication/login/data/repo/login_repo.dart';
import 'package:electronic_shop/features/authentication/login/domain/repo/i_login_repo.dart';
import 'package:electronic_shop/features/authentication/login/domain/usecases/email_login.dart';
import 'package:electronic_shop/features/authentication/login/domain/usecases/google_login.dart';
import 'package:electronic_shop/features/authentication/login/presentation/controller/login_controller.dart';
import 'package:electronic_shop/features/on_boarding/data/repo/onboarding_repo.dart';
import 'package:electronic_shop/features/on_boarding/domain/repo/i_onboarding_repo.dart';
import 'package:electronic_shop/features/on_boarding/domain/use_cases/set_onboarding.dart';
import 'package:electronic_shop/features/on_boarding/presentation/controller/onboarding_controller.dart';
import 'package:electronic_shop/features/profile/data/data_sources/local_data_source.dart';
import 'package:electronic_shop/features/home/home_controller.dart';
import 'package:electronic_shop/features/products/data/data_sources/local_data_source.dart';
import 'package:electronic_shop/features/products/data/data_sources/remote_data_source.dart';
import 'package:electronic_shop/features/products/data/repo/product_repo.dart';
import 'package:electronic_shop/features/products/domain/repo/i_product_repo.dart';
import 'package:electronic_shop/features/products/domain/usecases/clear_cache_usecase.dart';
import 'package:electronic_shop/features/products/domain/usecases/fetch_products_usecase.dart';
import 'package:electronic_shop/features/products/presentation/controller/product_controller.dart';
import 'package:electronic_shop/features/profile/data/repo/profile_repo.dart';
import 'package:electronic_shop/features/profile/domain/repo/i_profile_repo.dart';
import 'package:electronic_shop/features/profile/domain/use_cases/logout.dart';
import 'package:electronic_shop/features/profile/presentation/controllers/profile_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final instance = GetIt.instance;

Future<void> init() async {
  //###### onboarding #####
  //controller
  instance.registerFactory<OnboardingController>(
      () => OnboardingController(instance.call()));

  //use case
  instance.registerLazySingleton<SetOnboardingUseCase>(
      () => SetOnboardingUseCase(instance.call()));

  //repo
  instance.registerLazySingleton<IOnboardingRepo>(() => OnboardingRepo());

  // ######### Auth #########
  //view model
  instance.registerFactory<LoginController>(() => LoginController(
      emailLoginUsecase: instance.call(),
      connectionStatus: instance.call(),
      userDb: instance.call(),
      googleLoginUsecase: instance.call()));

  //usecase
  instance.registerLazySingleton<EmailLoginUsecase>(
      () => EmailLoginUsecase(instance.call()));
  instance.registerLazySingleton<GoogleLoginUsecase>(
      () => GoogleLoginUsecase(instance.call()));

  //repo
  instance.registerLazySingleton<ILoginRepo>(() =>
      LoginRepo(remoteDataSource: instance.call(), userDb: instance.call()));

  //data source
  instance.registerLazySingleton<ILoginRemoteDataSource>(
      () => LoginRemoteDataSource(firebaseAuth: instance.call()));

  instance.registerLazySingleton<UserDb>(() => UserDb());

  // firebase auth
  instance.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  // connection status
  instance
      .registerLazySingleton<NetworkInfo>(() => NetworkInfo(Connectivity()));
  // http client
  instance.registerLazySingleton(() => http.Client());

  // ####### Home #######
  // view model
  instance.registerFactory<HomeController>(() => HomeController());

  // ##### Products #####
  // vidw model
  instance.registerFactory<ProductController>(() => ProductController(
      fetchUsecase: instance.call(), clearCacheUsecase: instance.call()));

  // usecase
  instance.registerLazySingleton<FetchProductsUsecase>(
      () => FetchProductsUsecase(productRepo: instance.call()));

  instance.registerLazySingleton<ClearCacheUsecase>(
      () => ClearCacheUsecase(productRepo: instance.call()));
  // repo
  instance.registerLazySingleton<IProductRepo>(() => ProductRepo(
      connectionStatus: instance.call(),
      remoteDataSource: instance.call(),
      localDataSource: instance.call()));
  // data source
  instance.registerLazySingleton<IProductRemoteDataSource>(
      () => ProductRemoteDataSource(client: instance.call()));

  instance.registerLazySingleton<IProductLocalDataSource>(
      () => ProductLocalDataSource());
  //

  // ####### profile #######
  //controller
  instance.registerFactory<ProfileController>(
      () => ProfileController(instance.call()));
  //use case
  instance.registerLazySingleton<LogoutUsecase>(
      () => LogoutUsecase(instance.call()));
  //repo
  instance.registerLazySingleton<IProfileRepo>(() => ProfileRepo());
}
