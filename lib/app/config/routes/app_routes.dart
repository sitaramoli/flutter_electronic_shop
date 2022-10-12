import 'package:electronic_shop/features/authentication/login/presentation/view/login_view.dart';
import 'package:electronic_shop/features/home/home_view.dart';
import 'package:electronic_shop/features/on_boarding/presentation/view/onboarding_view.dart';
import 'package:electronic_shop/features/splash/splash_view.dart';
import 'package:flutter/material.dart';

class Routes {
  static const splashRoute = '/';
  static const onBoardingRoute = '/onboarding';
  static const loginRoute = '/login';
  static const registerRoute = '/register';
  static const homeRoute = '/home';
  static const productRoute = '/product';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (_) =>  OnboardingView());
      case Routes.loginRoute:
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
