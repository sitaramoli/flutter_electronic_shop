import 'package:hive/hive.dart';

class Preferences {
  static const _preferencesBox = 'PREFERENCES_BOX';
  static const _loggedInKey = 'LOGGED_IN_KEY';
  static const _onboardingKey = 'ON_BOARDING_KEY';
  final Box _box;
  Preferences._(this._box);

  static Future<Preferences> getInstance() async {
    final box = await Hive.openBox(_preferencesBox);
    return Preferences._(box);
  }

  bool isLoggedIn() {
    return _box.get(_loggedInKey, defaultValue: false);
  }

  bool showOnboarding() {
    return _box.get(_onboardingKey, defaultValue: true);
  }

  Future<void> setLoggedIn() async {
    await _box.put(_loggedInKey, true);
  }

  Future<void> logout() async {
    await _box.put(_loggedInKey, false);
  }

  Future<void> setOnboarding() async {
    await _box.put(_onboardingKey, false);
  }
}
