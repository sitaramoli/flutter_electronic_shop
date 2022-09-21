import 'package:dartz/dartz.dart';
import 'package:electronic_shop/app/core/error/failures.dart';
import 'package:electronic_shop/features/products/domain/entities/product.dart';
import 'package:electronic_shop/features/products/domain/repo/i_product_repo.dart';

class FetchProductsUsecase {
  final IProductRepo productRepo;

  FetchProductsUsecase({required this.productRepo});

  Future<Either<Failure, List<Product>>> execute() async {
    return await productRepo.fetchProducts();
  }
}
