import 'package:electronic_shop/app/core/constants/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 100,
          width: 100,
          child: Lottie.asset(
            AssetsManager.LOADING,
            repeat: true,
            fit: BoxFit.scaleDown,
          ),
        ),
      ),
    );
  }
}
