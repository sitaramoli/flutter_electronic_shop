import 'dart:async';

import 'package:electronic_shop/app/config/routes/app_routes.dart';
import 'package:electronic_shop/app/core/constants/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;
  late Box box;
  _startDelay() {
    _timer = Timer(const Duration(seconds: 2), _goNext);
  }

  _goNext() {
    final uid = box.get('uid');
    if (uid != null) {
      Navigator.pushReplacementNamed(context, Routes.homeRoute);
    } else {
      Navigator.pushReplacementNamed(context, Routes.loginRoute);
    }
  }

  void openBox() async {
    box = await Hive.openBox('userDb');
  }

  @override
  void initState() {
    super.initState();
    openBox();
    _startDelay();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Image(
          height: double.infinity,
          width: double.infinity,
          image: AssetImage(AssetsManager.SPLASH),
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
