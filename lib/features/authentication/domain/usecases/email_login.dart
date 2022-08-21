import 'package:dartz/dartz.dart';
import 'package:electronic_shop/app/exceptions/failures.dart';
import 'package:electronic_shop/features/authentication/domain/entities/user.dart';
import 'package:electronic_shop/features/authentication/domain/repo/i_auth_repo.dart';

class EmailLoginUsecase {
  final IAuthRepo authRepo;
  EmailLoginUsecase(this.authRepo);

  Future<Either<Failure, UserEntity>> execute(UserEntity user) async {
    return await authRepo.emailLogin(user);
  }
}
