import 'dart:convert';
import 'dart:io';
import 'package:electronic_shop/app/core/api/end_points.dart';
import 'package:http/http.dart' as http;

import 'package:electronic_shop/app/core/error/exceptions.dart';
import 'package:electronic_shop/features/products/data/models/product_model.dart';

abstract class IProductRemoteDataSource {
  Future<List<ProductModel>> fetchProducts();
}

class ProductRemoteDataSource implements IProductRemoteDataSource {
  final http.Client client;
  ProductRemoteDataSource({required this.client});
  @override
  Future<List<ProductModel>> fetchProducts() async {
    try {
      final response = await client.get(Uri.parse(EndPoints.PRODUCTS));
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final list = (json['data']['product'] as List)
            .map((e) => ProductModel.fromJson(e))
            .toList();
        return list;
      } else {
        throw ServerException();
      }
    } on SocketException {
      throw NetworkException();
    }
  }
}
