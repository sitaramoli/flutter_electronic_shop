import 'package:electronic_shop/features/cart/domain/entities/cart.dart';

abstract class CartRepo {
  Future<Cart> fetchCart();
}
