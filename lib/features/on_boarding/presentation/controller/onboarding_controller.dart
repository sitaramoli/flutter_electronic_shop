import 'package:electronic_shop/features/on_boarding/domain/use_cases/set_onboarding.dart';
import 'package:flutter/cupertino.dart';

class OnboardingController extends ChangeNotifier {
  final SetOnboardingUseCase setOnboardingUseCase;
  OnboardingController(this.setOnboardingUseCase);

  void setOnboarding() async {
    await setOnboardingUseCase.execute();
  }
}
