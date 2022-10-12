import 'package:electronic_shop/features/on_boarding/domain/repo/i_onboarding_repo.dart';

class SetOnboardingUseCase {
  final IOnboardingRepo onboardingRepo;
  SetOnboardingUseCase(this.onboardingRepo);

  Future<void> execute() async {
    await onboardingRepo.setOnboarding();
  }
}
