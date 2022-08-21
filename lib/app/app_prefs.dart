import 'package:shared_preferences/shared_preferences.dart';

class AppPrefs {
  final SharedPreferences preferences;
  AppPrefs(this.preferences);

  Future<void> setToken(String uid) async {
    preferences.setString('uid', uid);
  }

  Future<void> logout() async {
    await preferences.remove('uid');
  }

  Future<String> getToken() async {
    return preferences.getString('uid') ?? '';
  }
}
