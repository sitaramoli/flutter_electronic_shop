import 'dart:async';
import 'dart:math';

import 'package:electronic_shop/app/config/preferences/preferences.dart';
import 'package:electronic_shop/app/config/routes/app_routes.dart';
import 'package:electronic_shop/app/core/constants/color_manager.dart';
import 'package:electronic_shop/app/core/constants/strings_manager.dart';
import 'package:electronic_shop/app/core/constants/value_manager.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;
  double textOpacity = 0;
  late Preferences preferences;
  _startDelay() {
    _timer = Timer(const Duration(seconds: 2), _goNext);
  }

  _goNext() {
    if (preferences.isLoggedIn()) {
    Navigator.pushReplacementNamed(context, Routes.homeRoute);
    } else {
    if (preferences.showOnboarding()) {
    Navigator.pushReplacementNamed(context, Routes.onBoardingRoute);
    } else {
    Navigator.pushReplacementNamed(context, Routes.loginRoute);
    }
    }
  }

  void getPrefs() async {
    preferences = await Preferences.getInstance();
  }

  @override
  void initState() {
    super.initState();
    getPrefs();
    _startDelay();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: ColorManager.FORM_GRADIENT,
          transform: GradientRotation(pi / 2),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TweenAnimationBuilder(
              curve: Curves.linear,
              duration: const Duration(milliseconds: 300),
              tween: Tween<double>(begin: AppSize.S10, end: AppSize.S200),
              builder: (context, dynamic value, child) {
                return Icon(
                  Icons.shopping_cart_outlined,
                  color: ColorManager.DARK_GREY,
                  size: value,
                );
              },
              onEnd: () {
                setState(() {
                  textOpacity = 1;
                });
              },
            ),
            const SizedBox(height: AppSize.S20),
            Center(
              child: AnimatedOpacity(
                duration: const Duration(seconds: 1),
                opacity: textOpacity,
                child: Text(StringManager.SPLASH,
                    style: Theme.of(context).textTheme.headline1),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
