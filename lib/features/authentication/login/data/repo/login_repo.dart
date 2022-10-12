import 'package:dartz/dartz.dart';
import 'package:electronic_shop/app/core/error/exceptions.dart';
import 'package:electronic_shop/app/core/error/failures.dart';
import 'package:electronic_shop/features/authentication/login/data/data_sources/login_remote_data_source.dart';
import 'package:electronic_shop/features/authentication/login/domain/entities/user_entity.dart';
import 'package:electronic_shop/features/authentication/login/domain/repo/i_login_repo.dart';
import 'package:electronic_shop/features/profile/data/data_sources/local_data_source.dart';

class LoginRepo implements ILoginRepo {
  final ILoginRemoteDataSource remoteDataSource;
  final UserDb userDb;
  LoginRepo({required this.remoteDataSource, required this.userDb});

  @override
  Future<Either<Failure, UserEntity>> emailLogin(UserEntity userLogin) async {
    try {
      final data = await remoteDataSource.emailLogin(userLogin);
      final user = data.toEntity();
      await userDb.setUser(user);
      return Right(user);
    } on AuthException catch (e) {
      return Left(AuthFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> googleLogin() async {
    try {
      final data = await remoteDataSource.googleLogin();
      final user = data.toEntity();
      await userDb.setUser(user);
      return Right(user);
    } on AuthException catch (e) {
      return Left(AuthFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  
}
