import 'package:electronic_shop/app/core/constants/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MyErrorWidget extends StatelessWidget {
  const MyErrorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 200,
          width: 200,
          child: Lottie.asset(
            AssetsManager.ERROR,
            repeat: false,
            fit: BoxFit.scaleDown,
          ),
        ),
      ),
    );
  }
}
