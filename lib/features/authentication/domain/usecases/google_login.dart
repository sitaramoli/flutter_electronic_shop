import 'package:dartz/dartz.dart';
import 'package:electronic_shop/app/exceptions/failures.dart';
import 'package:electronic_shop/features/authentication/domain/entities/user.dart';
import 'package:electronic_shop/features/authentication/domain/repo/i_auth_repo.dart';

class GoogleLoginUsecase {
  final IAuthRepo authRepo;
  GoogleLoginUsecase(this.authRepo);

  Future<Either<Failure, UserEntity>> execute() async {
    return await authRepo.googleLogin();
  }
}
