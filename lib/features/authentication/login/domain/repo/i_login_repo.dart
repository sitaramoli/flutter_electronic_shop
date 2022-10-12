import 'package:dartz/dartz.dart';
import 'package:electronic_shop/app/core/error/failures.dart';
import 'package:electronic_shop/features/authentication/login/domain/entities/user_entity.dart';

abstract class ILoginRepo {
  Future<Either<Failure, UserEntity>> emailLogin(UserEntity user);
  Future<Either<Failure, UserEntity>> googleLogin();
}
