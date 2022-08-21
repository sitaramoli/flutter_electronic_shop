import 'package:dartz/dartz.dart';
import 'package:electronic_shop/app/exceptions/failures.dart';
import 'package:electronic_shop/features/authentication/domain/entities/user.dart';

abstract class IAuthRepo {
  Future<Either<Failure, UserEntity>> emailLogin(UserEntity user);
  Future<Either<Failure, UserEntity>> googleLogin();
  Future<void> logout();
}
