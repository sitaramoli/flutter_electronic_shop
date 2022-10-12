import 'package:electronic_shop/app/config/preferences/preferences.dart';
import 'package:electronic_shop/features/on_boarding/domain/repo/i_onboarding_repo.dart';

class OnboardingRepo implements IOnboardingRepo {
  @override
  Future<void> setOnboarding() async {
    final prefs = await Preferences.getInstance();
    prefs.setOnboarding();
  }
}
