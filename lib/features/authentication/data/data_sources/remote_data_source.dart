import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:electronic_shop/app/exceptions/exceptions.dart';
import 'package:electronic_shop/app/exceptions/failures.dart';
import 'package:electronic_shop/features/authentication/data/models/user_model.dart';
import 'package:electronic_shop/features/authentication/domain/entities/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class IAuthRemoteDataSource {
  Future<Either<Failure, UserModel>> emailLogin(UserEntity user);
  Future<Either<Failure, UserModel>> googleLogin();
}

class AuthRemoteDataSource implements IAuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  AuthRemoteDataSource({required this.firebaseAuth});

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Future<Either<Failure, UserModel>> emailLogin(UserEntity user) async {
    try {
      final userCredential = await firebaseAuth.signInWithEmailAndPassword(
          email: user.email!, password: user.password!);
      return Right(UserModel(email: userCredential.user?.email,uid: userCredential.user?.uid));
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure(message: e.message!));
    } on SocketException {
      try {
        throw NetworkException();
      } on NetworkException catch (e) {
        return Left(NetworkFailure(message: e.message));
      }
    } on Exception {
      return const Left(OtherFailure());
    }
  }

  @override
  Future<Either<Failure, UserModel>> googleLogin() async {
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
      return Right(
        UserModel(
          name: usercredential.user?.displayName,
          email: usercredential.user?.email,
          image: usercredential.user?.photoURL,
          uid: usercredential.user?.uid,
        ),
      );
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure(message: e.message!));
    } on SocketException {
      try {
        throw NetworkException();
      } on NetworkException catch (e) {
        return Left(NetworkFailure(message: e.message));
      }
    } on Exception {
      return const Left(OtherFailure());
    }
  }
}
