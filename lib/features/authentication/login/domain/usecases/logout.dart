import 'package:electronic_shop/features/authentication/login/domain/repo/i_login_repo.dart';

class LogoutUsecase {
  final ILoginRepo authRepo;

  LogoutUsecase({required this.authRepo});

  Future<void> execute() async {
    await authRepo.logout();
  }
}
