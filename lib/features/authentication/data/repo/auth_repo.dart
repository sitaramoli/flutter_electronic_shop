import 'package:dartz/dartz.dart';
import 'package:electronic_shop/app/app_prefs.dart';
import 'package:electronic_shop/app/exceptions/failures.dart';
import 'package:electronic_shop/features/authentication/data/data_sources/remote_data_source.dart';
import 'package:electronic_shop/features/authentication/domain/entities/user.dart';
import 'package:electronic_shop/features/authentication/domain/repo/i_auth_repo.dart';

class AuthRepo implements IAuthRepo {
  final IAuthRemoteDataSource remoteDataSource;
  final AppPrefs appPrefs;
  AuthRepo({required this.remoteDataSource, required this.appPrefs});

  @override
  Future<Either<Failure, UserEntity>> emailLogin(UserEntity user) async {
    try {
      return (await remoteDataSource.emailLogin(user))
          .fold((failure) => Left(failure), (data) async {
        await appPrefs.setToken(data.uid!);
        return Right(data.toEntity());
      });
    } on Exception {
      return const Left(OtherFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntity>> googleLogin() async {
    try {
      return (await remoteDataSource.googleLogin())
          .fold((failure) => Left(failure), (data) async {
        await appPrefs.setToken(data.uid!);
        return Right(data.toEntity());
      });
    } on Exception {
      throw const OtherFailure();
    }
  }

  @override
  Future<void> logout() async {
    await appPrefs.logout();
  }
}
