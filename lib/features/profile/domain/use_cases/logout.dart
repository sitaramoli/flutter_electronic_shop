import 'package:electronic_shop/features/profile/domain/repo/i_profile_repo.dart';

class LogoutUsecase {
  final IProfileRepo profileRepo;
  LogoutUsecase(this.profileRepo);

  Future<void> execute() async {
    await profileRepo.logout();
  }
}
