import 'package:electronic_shop/app/config/preferences/preferences.dart';
import 'package:electronic_shop/features/profile/domain/repo/i_profile_repo.dart';

class ProfileRepo implements IProfileRepo {
  @override
  Future<void> logout() async {
    final prefs = await Preferences.getInstance();
    prefs.logout();
  }
}
