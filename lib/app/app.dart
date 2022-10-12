import 'package:electronic_shop/app/config/routes/app_routes.dart';
import 'package:electronic_shop/app/config/themes/theme_manager.dart';
import 'package:electronic_shop/features/authentication/login/presentation/controller/login_controller.dart';
import 'package:electronic_shop/features/home/home_controller.dart';
import 'package:electronic_shop/features/products/presentation/controller/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:electronic_shop/dependency_injection.dart' as di;

class ElectronicShopApp extends StatefulWidget {
  const ElectronicShopApp._internal();
  static const ElectronicShopApp instance = ElectronicShopApp._internal();
  factory ElectronicShopApp() => instance;

  @override
  State<ElectronicShopApp> createState() => _ElectronicShopAppState();
}

class _ElectronicShopAppState extends State<ElectronicShopApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginController>(
            create: (_) => di.instance<LoginController>()),
        ChangeNotifierProvider<HomeController>(create: (_) => HomeController()),
        ChangeNotifierProvider<ProductController>(
            create: (_) => di.instance<ProductController>()),
      ],
      child: MaterialApp(
        title: 'Electronic Shop',
        debugShowCheckedModeBanner: false,
        theme: ThemeManager.themeData,
        initialRoute: Routes.splashRoute,
        onGenerateRoute: (settings) => RouteGenerator.getRoute(settings),
      ),
    );
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }
}
