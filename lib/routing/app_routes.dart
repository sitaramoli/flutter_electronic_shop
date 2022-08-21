import 'package:electronic_shop/features/authentication/presentation/login/login.dart';
import 'package:electronic_shop/features/authentication/presentation/splash/splash_view.dart';
import 'package:electronic_shop/features/cart/home_view.dart';
import 'package:flutter/material.dart';

class Routes {
  static const splashRoute = '/';
  static const authRoute = '/auth';
  static const homeRoute = '/home';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.authRoute:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case Routes.homeRoute:
        return MaterialPageRoute(builder: (_) => const HomeView());
      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => const Scaffold(
        body: Center(
          child: Text('No route found'),
        ),
      ),
    );
  }
}
