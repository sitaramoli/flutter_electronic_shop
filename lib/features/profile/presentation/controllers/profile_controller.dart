import 'package:electronic_shop/features/profile/domain/use_cases/logout.dart';
import 'package:flutter/cupertino.dart';

class ProfileController extends ChangeNotifier {
  final LogoutUsecase logoutUsecase;

  ProfileController(this.logoutUsecase);

  void logout() async {
    await logoutUsecase.execute();
  }
}
