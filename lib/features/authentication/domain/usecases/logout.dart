import 'package:electronic_shop/features/authentication/domain/repo/i_auth_repo.dart';

class LogoutUsecase {
  final IAuthRepo authRepo;

  LogoutUsecase({required this.authRepo});

  Future<void> execute() async {
    await authRepo.logout();
  }
}
