import 'package:electronic_shop/app/config/routes/app_routes.dart';
import 'package:electronic_shop/app/core/constants/assets_manager.dart';
import 'package:electronic_shop/app/core/constants/strings_manager.dart';
import 'package:electronic_shop/app/core/constants/value_manager.dart';
import 'package:electronic_shop/dependency_injection.dart';
import 'package:electronic_shop/features/on_boarding/presentation/controller/onboarding_controller.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OnboardingView extends StatelessWidget {
  OnboardingView({Key? key}) : super(key: key);
  final controller = instance<OnboardingController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          LottieBuilder.asset(AssetsManager.ONBOARDING, repeat: true),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(AppPadding.P30),
            child: Column(
              children: [
                Text(StringManager.ONBOARDING_TITLE,
                    style: Theme.of(context).textTheme.headline1),
                const SizedBox(height: 20),
                Text(StringManager.ONBOARDING_SUB_TITLE,
                    style: Theme.of(context).textTheme.subtitle1),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
              onPressed: () {
                controller.setOnboarding();
                Navigator.of(context).pushReplacementNamed(Routes.loginRoute);
              },
              child: const Text(StringManager.ONBOARDING_BUTTON))
        ],
      )),
    );
  }
}
