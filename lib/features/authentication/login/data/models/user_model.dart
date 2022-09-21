import 'package:electronic_shop/features/authentication/login/domain/entities/user_entity.dart';

class UserModel {
  final String? password;
  final String? email;
  final String? name;
  final String? image;
  final String? uid;

  const UserModel({this.name, this.image, this.email, this.password, this.uid});

  UserEntity toEntity() => UserEntity(
      email: email, password: password, name: name, image: image, uid: uid);
}
