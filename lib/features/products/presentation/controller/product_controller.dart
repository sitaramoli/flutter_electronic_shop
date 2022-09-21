import 'package:electronic_shop/app/core/constants/app_state.dart';
import 'package:electronic_shop/app/core/constants/strings_manager.dart';
import 'package:electronic_shop/app/core/widgets/snackbar.dart';
import 'package:electronic_shop/features/products/domain/entities/product.dart';
import 'package:electronic_shop/features/products/domain/usecases/clear_cache_usecase.dart';
import 'package:electronic_shop/features/products/domain/usecases/fetch_products_usecase.dart';
import 'package:flutter/cupertino.dart';

class ProductController extends ChangeNotifier {
  final FetchProductsUsecase fetchUsecase;
  final ClearCacheUsecase clearCacheUsecase;

  ProductController(
      {required this.fetchUsecase, required this.clearCacheUsecase});

  AppState _state = AppState.IDEAL;
  AppState get state => _state;

  List<Product> _products = [];
  List<Product> get products => _products;

  _setState(AppState state) {
    _state = state;
    notifyListeners();
  }

  Future<void> fetchProducts() async {
    _setState(AppState.LOADING);
    (await fetchUsecase.execute()).fold((failure) {
      _setState(AppState.ERROR);
      ErrorSnackBar.build(message: failure.message, error: true);
    }, (data) {
      _products = data;
      _setState(AppState.SUCCESS);
    });
  }

  Future<void> clearCache() async {
    await clearCacheUsecase.execute(StringManager.PRODUCT_CACHE_KEY);
  }
}
