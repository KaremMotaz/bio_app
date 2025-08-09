import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/errors/auth_failure.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/errors/firestore_failure.dart';
import '../../../../core/helpers/backend_endpoint.dart';
import '../../../../core/helpers/constants.dart';
import '../../../../core/services/cache_helper.dart';
import '../../../../core/services/data_service.dart';
import '../../../../core/services/firebase_auth_service.dart';
import '../../domain/auth_repo.dart';
import '../../domain/user_entity.dart';
import '../models/user_model.dart';

class AuthRepoImp extends AuthRepo {
  final FirebaseAuthService firebaseAuthService;
  final DatabaseService databaseService;

  AuthRepoImp({
    required this.firebaseAuthService,
    required this.databaseService,
  });

  @override
  Future<Either<Failure, UserEntity>> signupWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    User? user;
    try {
      user = await firebaseAuthService.signUpWithEmailAndPassword(
        email: email,
        password: password,
      );
      UserEntity userEntity = UserEntity(email: email, uid: user!.uid);
      await addUserData(userEntity: userEntity);
      return right(userEntity);
    } on FirebaseAuthException catch (e) {
      return left(AuthFailure.fromCode(e.code));
    } on FirestoreFailure catch (e) {
      return left(FirestoreFailure.fromCode(e.errMessage));
    } catch (e) {
      return left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signinWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    User? user;
    try {
      user = await firebaseAuthService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return right(UserEntity(email: email, uid: user!.uid));
    } on FirebaseAuthException catch (e) {
      log(e.toString());
      return left(AuthFailure.fromCode(e.code));
    } catch (e) {
            log(e.toString());

      return left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signinWithGoogle() async {
    User? user;
    try {
      user = await firebaseAuthService.signinWithGoogle();
      UserEntity studentEntity = UserModel.fromFirebaseUser(user);
      await addUserData(userEntity: studentEntity);
      return right(studentEntity);
    } on FirebaseAuthException catch (e) {
      return left(AuthFailure.fromCode(e.code));
    } catch (e) {
      return left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signinWithFacebook() async {
    User? user;
    try {
      user = await firebaseAuthService.signinWithFacebook();
      UserEntity studentEntity = UserModel.fromFirebaseUser(user);
      await addUserData(userEntity: studentEntity);
      return right(studentEntity);
    } on FirebaseAuthException catch (e) {
      return left(AuthFailure.fromCode(e.code));
    } catch (e) {
      return left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> sendLinkToResetPassword({
    required String email,
  }) async {
    try {
      await firebaseAuthService.sendLinkToResetPassword(email: email);
      return right(unit);
    } on FirebaseAuthException catch (e) {
      return left(AuthFailure.fromCode(e.code));
    } catch (e) {
      return left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> sendEmailVerification() async {
    try {
      await firebaseAuthService.sendEmailVerification();
      return right(unit);
    } on FirebaseAuthException catch (e) {
      return left(AuthFailure.fromCode(e.code));
    } catch (e) {
      return left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> logOut() async {
    try {
      await firebaseAuthService.logOut();
    } on FirebaseAuthException catch (e) {
      return left(AuthFailure.fromCode(e.code));
    }
    return left(AuthFailure("Logged out unexpectedly"));
  }

  @override
  Future<Either<Failure, UserEntity>> addUserData({
    required UserEntity userEntity,
  }) async {
    await databaseService.addData(
      path: BackendEndpoint.addUserData,
      data: UserModel.fromEntity(userEntity).toMap(),
      documentId: userEntity.uid,
    );
    return right(userEntity);
  }

  @override
  Future<UserEntity> getUserData({required String uid}) async {
    var studentData = await databaseService.getData(
      path: BackendEndpoint.getUserData,
      documentId: uid,
    );
    return UserModel.fromJson(studentData);
  }

  @override
  Future saveUserData({required UserEntity userEntity}) async {
    var jsonData = jsonEncode(UserModel.fromEntity(userEntity).toMap());
    await CacheHelper.set(key: kUserData, value: jsonData);
  }
}
