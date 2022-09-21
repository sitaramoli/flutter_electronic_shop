import 'package:electronic_shop/features/products/domain/entities/product.dart';
import 'package:equatable/equatable.dart';

enum Category { electronic, headset, laptop, mobile, watch, keyboard }

class ProductModel extends Equatable {
  final int id;
  final String name;
  final String image;
  final String price;
  final int stock;
  final int createDate;
  final List category;

  const ProductModel(
      {required this.id,
      required this.name,
      required this.image,
      required this.price,
      required this.stock,
      required this.createDate,
      required this.category});

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      price: json['price'],
      stock: json['stock'],
      createDate: json['createDate'],
      category: json['category']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "price": price,
        "stock": stock,
        "createDate": createDate,
      };

  Product toEntity() => Product(
      id: id,
      name: name,
      price: price,
      image: image,
      stock: stock,
      createDate: createDate,
      category: category);

  @override
  List<Object?> get props =>
      [id, name, image, price, stock, createDate, category];
}
