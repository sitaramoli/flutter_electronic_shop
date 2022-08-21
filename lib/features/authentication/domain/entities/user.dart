import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? email;
  final String? password;
  final String? name;
  final String? image;
  final String? uid;

  const UserEntity(
      {this.email, this.password, this.name, this.image, this.uid});

  @override
  List<Object?> get props => [email, password, name, image, uid];
}
