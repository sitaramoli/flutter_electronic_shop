import 'package:electronic_shop/app/constants/assets_constants.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 100,
        width: 100,
        child: Lottie.asset(
          AssetsConstants.loadingAnimation,
          repeat: true,
          fit: BoxFit.scaleDown,
        ),
      ),
    );
  }
}
