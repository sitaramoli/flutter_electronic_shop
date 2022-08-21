import 'package:electronic_shop/app/app_prefs.dart';
import 'package:electronic_shop/app/check_connection/connection_status.dart';
import 'package:electronic_shop/app/constants/string_constants.dart';
import 'package:electronic_shop/common_widgets/error_snackbar.dart';
import 'package:electronic_shop/features/authentication/domain/entities/user.dart';
import 'package:electronic_shop/features/authentication/domain/usecases/email_login.dart';
import 'package:electronic_shop/features/authentication/domain/usecases/google_login.dart';
import 'package:electronic_shop/features/authentication/domain/usecases/logout.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  final EmailLoginUsecase emailLoginUsecase;
  final GoogleLoginUsecase googleLoginUsecase;
  final LogoutUsecase logoutUsecase;
  final AppPrefs appPrefs;
  final ConnectionStatus connectionStatus;

  LoginViewModel({
    required this.emailLoginUsecase,
    required this.googleLoginUsecase,
    required this.logoutUsecase,
    required this.appPrefs,
    required this.connectionStatus,
  });

  bool _passwordVisible = false;
  bool get passwordVisible => _passwordVisible;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<bool> isAuthenticated() async {
    final uid = await appPrefs.getToken();
    if (uid.isNotEmpty) {
      return true;
    } else {
      return false;
    }
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
          ErrorSnackBar.build(message: failure.message);
          toggleLoading();
        }, (data) {
          toggleLoading();
        });
      } catch (_) {
        ErrorSnackBar.build(message: StringConstants.unknownError);
        toggleLoading();
      }
    } else {
      ErrorSnackBar.build(message: StringConstants.noInternet);
    }
  }

  Future<void> googleSignin() async {
    if (await connectionStatus.hasConnection) {
      toggleLoading();

      try {
        (await googleLoginUsecase.execute()).fold((failure) {
          ErrorSnackBar.build(message: failure.message);
          toggleLoading();
        }, (data) {
          toggleLoading();
        });
      } catch (_) {
        ErrorSnackBar.build(message: StringConstants.unknownError);
        toggleLoading();
      }
    } else {
      ErrorSnackBar.build(message: StringConstants.noInternet);
    }
  }

  Future<void> logout() async {
    await logoutUsecase.execute();
  }
}
