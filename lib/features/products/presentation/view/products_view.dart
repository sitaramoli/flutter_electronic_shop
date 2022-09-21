import 'package:electronic_shop/app/core/constants/app_state.dart';
import 'package:electronic_shop/app/core/widgets/error_widget.dart';
import 'package:electronic_shop/app/core/widgets/loading_widget.dart';
import 'package:electronic_shop/app/core/widgets/product_card.dart';
import 'package:electronic_shop/features/products/presentation/controller/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsView extends StatefulWidget {
  const ProductsView({Key? key}) : super(key: key);

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  // final controller = instance<ProductController>();

  @override
  void initState() {
    super.initState();
    final controller = context.read<ProductController>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ProductController>(context);

    switch (controller.state) {
      case AppState.IDEAL:
        return const LoadingWidget();
      case AppState.LOADING:
        return const LoadingWidget();
      case AppState.ERROR:
        return const MyErrorWidget();
      case AppState.SUCCESS:
        return _buildBody(controller);
    }
  }

  _buildBody(ProductController controller) {
    return RefreshIndicator(
      onRefresh: () async {
        controller.clearCache();
        controller.fetchProducts();
      },
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
          ),
          itemCount: controller.products.length,
          itemBuilder: (context, index) {
            return ProductCard(product: controller.products[index]);
          }),
    );
  }
}
