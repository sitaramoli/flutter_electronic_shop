import 'package:electronic_shop/app/core/api/end_points.dart';
import 'package:electronic_shop/app/core/constants/assets_manager.dart';
import 'package:electronic_shop/features/products/domain/entities/product.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.product,
  }) : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(children: [
            Image.network(
              EndPoints.IMAGE,
              errorBuilder: (context, error, stackTrace) => SizedBox(
                height: 200,
                width: 200,
                child: Image.asset(AssetsManager.PROFILE),
              ),
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '${product.stock} items',
                  style: TextStyle(
                    letterSpacing: 1,
                    backgroundColor: Theme.of(context).primaryColor,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ]),
          Padding(
            padding: const EdgeInsets.all(8),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                product.name,
                style: Theme.of(context).textTheme.headline4,
              ),
              const SizedBox(height: 10),
              Text(product.price, style: Theme.of(context).textTheme.headline5),
            ]),
          ),
        ],
      ),
    );
  }
}
