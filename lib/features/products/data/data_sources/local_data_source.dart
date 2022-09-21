import 'package:electronic_shop/app/core/constants/strings_manager.dart';
import 'package:electronic_shop/app/core/error/exceptions.dart';
import 'package:electronic_shop/features/products/data/models/product_model.dart';

abstract class IProductLocalDataSource {
  Future<List<ProductModel>> fetchProducts();
  Future<void> saveProductsToCache(List<ProductModel> list);
  void clearCache(String key);
}

class ProductLocalDataSource implements IProductLocalDataSource {
  Map<String, CachedProduct> cachedMap = {};

  @override
  Future<List<ProductModel>> fetchProducts() async {
    CachedProduct? cachedProduct = cachedMap[StringManager.PRODUCT_CACHE_KEY];
    if (cachedProduct != null) {
      return cachedProduct.data;
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> saveProductsToCache(List<ProductModel> list) async {
    cachedMap[StringManager.PRODUCT_CACHE_KEY] = CachedProduct(list);
  }

  @override
  void clearCache(String key) {
    cachedMap.remove(key);
  }
}

class CachedProduct {
  dynamic data;
  CachedProduct(this.data);
}
