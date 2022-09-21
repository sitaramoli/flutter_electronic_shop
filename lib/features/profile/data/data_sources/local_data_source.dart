import 'package:electronic_shop/features/authentication/login/domain/entities/user_entity.dart';
import 'package:hive/hive.dart';

class UserDb {
  late Box box;

  Future<void> setUser(UserEntity user) async {
    box = await Hive.openBox('userDb');
    box.put('uid', user.uid);
    box.put('email', user.email);
    box.put('name', user.name);
    box.put('image', user.image);
    box.put('loggedIn', true);
  }

  Future<void> logout() async {
    box = await Hive.openBox('userDb');
    box.clear();
  }
}
