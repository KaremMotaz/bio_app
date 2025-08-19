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
      UserEntity userEntity = UserEntity(
        email: email,
        uid: user!.uid,
      );
      return right(userEntity);
    } on FirebaseAuthException catch (e) {
      return left(AuthFailure.fromCode(e.code));
    } on FirestoreFailure catch (e) {
      await deleteUser();
      return left(FirestoreFailure.fromCode(e.message));
    } catch (e) {
      await deleteUser();
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
      UserEntity userEntity = await getUserData(uid: user!.uid);
      await saveUserData(userEntity: userEntity);
      return right(userEntity);
    } on FirebaseAuthException catch (e) {
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
      user = await firebaseAuthService.signinWithGoogle(
        serverClientId:
            "259409221329-faud1c409bhai79em307mkse5nriuv6k.apps.googleusercontent.com",
      );
      UserEntity userEntity = UserModel.fromFirebaseUser(user);

      final bool isUserExists = await checkIfDataExists(
        documentId: user.uid,
      );

      if (isUserExists) {
        UserEntity userEntity = await getUserData(uid: user.uid);
        await saveUserData(userEntity: userEntity);
      } else {
        await addUserData(userEntity: userEntity);
      }

      return right(userEntity);
    } on FirebaseAuthException catch (e) {
      await deleteUser();
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
      UserEntity userEntity = UserModel.fromFirebaseUser(user);
      await addUserData(userEntity: userEntity);
      final bool isUserExists = await checkIfDataExists(
        documentId: user.uid,
      );

      if (isUserExists) {
        UserEntity userEntity = await getUserData(uid: user.uid);
        await saveUserData(userEntity: userEntity);
      } else {
        await addUserData(userEntity: userEntity);
      }

      return right(userEntity);
    } on FirebaseAuthException catch (e) {
      await deleteUser();
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
      data: UserModel.fromEntity(userEntity).toFirestoreMap(),
      documentId: userEntity.uid,
    );
    return right(userEntity);
  }

  @override
  Future<UserEntity> getUserData({required String uid}) async {
    final Map<String, dynamic> userData = await databaseService
        .getData(path: BackendEndpoint.getUserData, documentId: uid);
    return UserModel.fromJson(userData);
  }

  @override
  Future saveUserData({required UserEntity userEntity}) async {
    String jsonData = jsonEncode(
      UserModel.fromEntity(userEntity).toJson(),
    );
    await CacheHelper.set(key: kUserData, value: jsonData);
  }

  @override
  Future deleteUser() async {
    return await firebaseAuthService.deleteAccount();
  }

  @override
  Future<bool> checkIfDataExists({required String documentId}) async {
    return await databaseService.checkIfDataExists(
      path: BackendEndpoint.checkIfDataExists,
      documentId: documentId,
    );
  }

  @override
  Future<Either<Failure, Unit>> updateUserData({
    required UserEntity userEntity,
  }) {
    throw UnimplementedError();
  }
}
