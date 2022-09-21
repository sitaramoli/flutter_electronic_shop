// ignore_for_file: constant_identifier_names, non_constant_identifier_names

class EndPoints {
  static const base = 'https://electronic-ecommerce.herokuapp.com';
  static const products = '/api/v1/product';
  static const image = '/fantechHeadset.jpg';

  static String get PRODUCTS => '$base$products';
  static String get IMAGE => '$base$image';
}
