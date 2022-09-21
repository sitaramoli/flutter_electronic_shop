import 'package:electronic_shop/app/core/constants/color_manager.dart';
import 'package:electronic_shop/features/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(builder: (context, controller, child) {
      return Scaffold(
        body: controller.pages[controller.currentIndex],
        bottomNavigationBar: GNav(
          tabs: controller.items,
          selectedIndex: controller.currentIndex,
          onTabChange: (value) => controller.updateIndex(value),
          tabBorderRadius: 30,
          rippleColor: ColorManager.FORM_GRADIENT[0],
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          tabActiveBorder: Border.all(color: ColorManager.FORM_GRADIENT[1]),
          color: Colors.grey[700],
          backgroundColor: ColorManager.WHITE,
          tabBackgroundColor: ColorManager.PRIMARY,
          activeColor: Colors.white,
          gap: 8,
          iconSize: 28,
          tabMargin: const EdgeInsets.symmetric(vertical: 5),
        ),
      );
    });
  }
}
