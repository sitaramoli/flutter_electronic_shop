import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int id;
  final String name;
  final String price;
  final String image;
  final int stock;
  final int createDate;
  final List category;

  const Product(
      {required this.id,
      required this.name,
      required this.price,
      required this.image,
      required this.stock,
      required this.createDate,
      required this.category});

  @override
  List<Object?> get props =>
      [id, name, image, price, stock, createDate, category];
}
