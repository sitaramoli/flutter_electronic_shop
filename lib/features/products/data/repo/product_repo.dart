import 'package:electronic_shop/app/core/error/exceptions.dart';
import 'package:electronic_shop/app/core/network/network_info.dart';
import 'package:electronic_shop/features/products/data/data_sources/local_data_source.dart';
import 'package:electronic_shop/features/products/data/data_sources/remote_data_source.dart';
import 'package:electronic_shop/features/products/domain/entities/product.dart';
import 'package:electronic_shop/app/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:electronic_shop/features/products/domain/repo/i_product_repo.dart';

class ProductRepo implements IProductRepo {
  final NetworkInfo connectionStatus;
  final IProductRemoteDataSource remoteDataSource;
  final IProductLocalDataSource localDataSource;

  ProductRepo({
    required this.connectionStatus,
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<Product>>> fetchProducts() async {
    try {
      return Right(await localDataSource
          .fetchProducts()
          .then((value) => value.map((e) => e.toEntity()).toList()));
    } catch (cacheException) {
      if (await connectionStatus.hasConnection) {
        try {
          final result = await remoteDataSource.fetchProducts();
          localDataSource.saveProductsToCache(result);
          return Right(result.map((e) => e.toEntity()).toList());
        } on NetworkException catch (e) {
          return Left(NetworkFailure(message: e.message));
        } on ServerException catch (e) {
          return Left(ServerFailure(message: e.message));
        }
      } else {
        return Left(NetworkFailure(message: 'No internet connection'));
      }
    }
  }

  @override
  Future<void> clearCache(String key) async {
    localDataSource.clearCache(key);
  }
}
