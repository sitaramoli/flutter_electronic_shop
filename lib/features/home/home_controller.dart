import 'package:electronic_shop/features/cart/view/cart_view.dart';
import 'package:electronic_shop/features/products/presentation/view/products_view.dart';
import 'package:electronic_shop/features/profile/presentation/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class HomeController extends ChangeNotifier {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  final _pages = <Widget>[
    const ProductsView(),
    const CartView(),
    const ProfileView(),
  ];

  final _items = <GButton>[
    const GButton(
      icon: LineIcons.home,
      text: 'Home',
    ),
    const GButton(
      icon: LineIcons.shoppingCart,
      text: 'Cart',
    ),
    const GButton(
      icon: LineIcons.user,
      text: 'Profile',
    ),
  ];

  List<GButton> get items => _items;
  List<Widget> get pages => _pages;

  void updateIndex(int newIndex) {
    _currentIndex = newIndex;
    notifyListeners();
  }
}
