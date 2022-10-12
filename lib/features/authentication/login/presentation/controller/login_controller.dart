import 'package:electronic_shop/app/config/preferences/preferences.dart';
import 'package:electronic_shop/app/core/constants/strings_manager.dart';
import 'package:electronic_shop/app/core/network/network_info.dart';
import 'package:electronic_shop/app/core/widgets/snackbar.dart';
import 'package:electronic_shop/features/authentication/login/domain/entities/user_entity.dart';
import 'package:electronic_shop/features/authentication/login/domain/usecases/email_login.dart';
import 'package:electronic_shop/features/authentication/login/domain/usecases/google_login.dart';
import 'package:electronic_shop/features/profile/data/data_sources/local_data_source.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class LoginController extends ChangeNotifier {
  final EmailLoginUsecase emailLoginUsecase;
  final GoogleLoginUsecase googleLoginUsecase;
  final UserDb userDb;
  final NetworkInfo connectionStatus;
  late Box box;

  LoginController({
    required this.emailLoginUsecase,
    required this.googleLoginUsecase,
    required this.userDb,
    required this.connectionStatus,
  });

  bool _passwordVisible = false;
  bool get passwordVisible => _passwordVisible;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<bool> isAuthenticated() async {
    final prefs = await Preferences.getInstance();
    return prefs.isLoggedIn();
  }

  void togglePasswordVisibility() {
    _passwordVisible = !_passwordVisible;
    notifyListeners();
  }

  void toggleLoading() {
    _isLoading = !_isLoading;
    notifyListeners();
  }

  Future<void> emailLogin(Map<String, dynamic> formData) async {
    if (await connectionStatus.hasConnection) {
      toggleLoading();
      try {
        final user = UserEntity(
            email: formData['email'], password: formData['password']);
        (await emailLoginUsecase.execute(user)).fold((failure) {
          ErrorSnackBar.build(message: failure.message, error: true);
          toggleLoading();
        }, (data) {
          toggleLoading();
        });
      } catch (_) {
        ErrorSnackBar.build(message: StringManager.UNKNOWN_ERROR, error: true);
        toggleLoading();
      }
    } else {
      ErrorSnackBar.build(message: StringManager.NO_INTERNET, error: true);
    }
  }

  Future<void> googleSignin() async {
    if (await connectionStatus.hasConnection) {
      toggleLoading();

      try {
        (await googleLoginUsecase.execute()).fold((failure) {
          ErrorSnackBar.build(message: failure.message, error: true);
          toggleLoading();
        }, (data) {
          toggleLoading();
        });
      } catch (_) {
        ErrorSnackBar.build(message: StringManager.UNKNOWN_ERROR, error: true);
        toggleLoading();
      }
    } else {
      ErrorSnackBar.build(message: StringManager.NO_INTERNET, error: true);
    }
  }
}
