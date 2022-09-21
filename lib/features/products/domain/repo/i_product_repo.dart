import 'package:dartz/dartz.dart';
import 'package:electronic_shop/app/core/error/failures.dart';
import 'package:electronic_shop/features/products/domain/entities/product.dart';

abstract class IProductRepo {
  Future<Either<Failure, List<Product>>> fetchProducts();
  Future<void> clearCache(String key);
}
