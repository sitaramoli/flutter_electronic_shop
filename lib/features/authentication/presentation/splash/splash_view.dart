import 'dart:async';

import 'package:electronic_shop/app/app_prefs.dart';
import 'package:electronic_shop/app/constants/assets_constants.dart';
import 'package:electronic_shop/dependency_injection.dart';
import 'package:electronic_shop/routing/app_routes.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;
  final AppPrefs _appPrefs = instance<AppPrefs>();

  _startDelay() {
    _timer = Timer(const Duration(seconds: 2), _goNext);
  }

  _goNext() async {
    _appPrefs.getToken().then((value) {
      if (value.isNotEmpty) {
        Navigator.pushReplacementNamed(context, Routes.homeRoute);
      } else {
        Navigator.pushReplacementNamed(context, Routes.authRoute);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Image(
          image: AssetImage(AssetsConstants.splash),
          fit: BoxFit.cover,
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
