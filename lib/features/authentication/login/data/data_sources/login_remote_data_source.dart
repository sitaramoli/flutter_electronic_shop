import 'dart:io';

import 'package:electronic_shop/app/core/error/exceptions.dart';
import 'package:electronic_shop/features/authentication/login/data/models/user_model.dart';
import 'package:electronic_shop/features/authentication/login/domain/entities/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class ILoginRemoteDataSource {
  Future<UserModel> emailLogin(UserEntity user);
  Future<UserModel> googleLogin();
}

class LoginRemoteDataSource implements ILoginRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  LoginRemoteDataSource({required this.firebaseAuth});

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Future<UserModel> emailLogin(UserEntity user) async {
    try {
      final userCredential = await firebaseAuth.signInWithEmailAndPassword(
          email: user.email!, password: user.password!);
      return UserModel(
          email: userCredential.user?.email, uid: userCredential.user?.uid);
    } on FirebaseAuthException catch (e) {
      throw AuthException(message: e.message!);
    } on SocketException {
      throw NetworkException();
    } on Exception {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> googleLogin() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw Exception();
      }

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final usercredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      return UserModel(
        name: usercredential.user?.displayName,
        email: usercredential.user?.email,
        image: usercredential.user?.photoURL,
        uid: usercredential.user?.uid,
      );
    } on FirebaseAuthException catch (e) {
      throw AuthException(message: e.message!);
    } on SocketException {
      throw NetworkException();
    } on Exception {
      throw ServerException();
    }
  }
}
