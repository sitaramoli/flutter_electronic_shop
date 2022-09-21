import 'package:dartz/dartz.dart';
import 'package:electronic_shop/app/core/error/failures.dart';
import 'package:electronic_shop/features/authentication/login/domain/entities/user_entity.dart';
import 'package:electronic_shop/features/authentication/login/domain/repo/i_login_repo.dart';

class EmailLoginUsecase {
  final ILoginRepo authRepo;
  EmailLoginUsecase(this.authRepo);

  Future<Either<Failure, UserEntity>> execute(UserEntity user) async {
    return await authRepo.emailLogin(user);
  }
}
