import 'package:electronic_shop/features/products/domain/repo/i_product_repo.dart';

class ClearCacheUsecase {
  final IProductRepo productRepo;
  ClearCacheUsecase({required this.productRepo});

  Future<void> execute(String key) async {
    await productRepo.clearCache(key);
  }
}
