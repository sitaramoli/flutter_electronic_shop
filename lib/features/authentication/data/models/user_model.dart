import 'package:electronic_shop/features/authentication/domain/entities/user.dart';

class UserModel {
  final String? email;
  final String? password;
  final String? name;
  final String? image;
  final String? uid;

  UserModel({this.name, this.image, this.email, this.password, this.uid});

  UserEntity toEntity() => UserEntity(
      email: email, password: password, name: name, image: image, uid: uid);
}
