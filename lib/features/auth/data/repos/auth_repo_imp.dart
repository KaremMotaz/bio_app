import 'dart:convert';
import '../../../../core/errors/server_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/errors/auth_failure.dart';
import '../../../../core/errors/failure.dart';
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
  static String userId = FirebaseAuth.instance.currentUser!.uid;

  AuthRepoImp({
    required this.firebaseAuthService,
    required this.databaseService,
  });
  @override
  Future<Either<Failure, UserEntity>> signupWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final Either<Failure, User> result = await firebaseAuthService
          .signUpWithEmailAndPassword(
            email: email,
            password: password,
          );

      return await result.fold(
        (failure) async {
          await deleteAccount();
          return left(failure);
        },
        (user) async {
          final userEntity = UserEntity(email: email, uid: user.uid);
          await addUserData(userEntity: userEntity);
          return right(userEntity);
        },
      );
    } catch (e) {
      await deleteAccount();
      return left(AuthFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signinWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final Either<Failure, User> result = await firebaseAuthService
          .signInWithEmailAndPassword(
            email: email,
            password: password,
          );

      return await result.fold(
        (failure) async {
          return left(failure);
        },
        (user) async {
          final userEntity = await getUserData(uid: user.uid);
          await saveUserData(userEntity: userEntity);
          return right(userEntity);
        },
      );
    } catch (e) {
      return left(AuthFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signinWithGoogle() async {
    try {
      final Either<Failure, User>
      result = await firebaseAuthService.signInWithGoogle(
        serverClientId:
            "259409221329-faud1c409bhai79em307mkse5nriuv6k.apps.googleusercontent.com",
      );

      return await result.fold(
        (failure) async {
          await deleteAccount();
          return left(failure);
        },
        (user) async {
          UserEntity userEntity = UserModel.fromFirebaseUser(user);

          final bool isUserExists = await checkIfDataExists(
            documentId: user.uid,
          );

          if (isUserExists) {
            userEntity = await getUserData(uid: user.uid);
            await saveUserData(userEntity: userEntity);
          } else {
            await addUserData(userEntity: userEntity);
          }

          return right(userEntity);
        },
      );
    } on FirebaseAuthException catch (e) {
      await deleteAccount();
      return left(AuthFailure.fromCode(e.code));
    } catch (e) {
      return left(AuthFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signinWithFacebook() async {
    try {
      final Either<Failure, User> result = await firebaseAuthService
          .signinWithFacebook();

      return await result.fold(
        (failure) async {
          await deleteAccount();
          return left(failure);
        },
        (user) async {
          UserEntity userEntity = UserModel.fromFirebaseUser(user);

          final bool isUserExists = await checkIfDataExists(
            documentId: user.uid,
          );

          if (isUserExists) {
            userEntity = await getUserData(uid: user.uid);
            await saveUserData(userEntity: userEntity);
          } else {
            await addUserData(userEntity: userEntity);
          }

          return right(userEntity);
        },
      );
    } on FirebaseAuthException catch (e) {
      await deleteAccount();
      return left(AuthFailure.fromCode(e.code));
    } catch (e) {
      return left(AuthFailure(message: e.toString()));
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
      return left(AuthFailure(message: e.toString()));
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
      return left(AuthFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> logOut() async {
    try {
      await firebaseAuthService.logOut();
    } on FirebaseAuthException catch (e) {
      return left(AuthFailure.fromCode(e.code));
    }
    return left(AuthFailure(message: "Logged out unexpectedly"));
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
        .getData(path: '${BackendEndpoint.getUserData}/$uid');
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
  Future<Either<Failure, Unit>> deleteAccount({
    String? password,
  }) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return left(
        const ServerFailure(
          code: 'no-user',
          message: 'No user is currently signed in.',
        ),
      );
    }

    try {
      final deleteResult = await firebaseAuthService.deleteAccount(
        password: password,
      );

      return deleteResult.fold(
        (failure) => left(failure),
        (_) => right(unit),
      );
    } catch (e) {
      return left(AuthFailure(message: e.toString()));
    }
  }

  @override
  Future<bool> checkIfDataExists({required String documentId}) async {
    try {
      return await databaseService.checkIfDataExists(
        path: '${BackendEndpoint.checkIfDataExists}/$documentId',
      );
    } catch (e) {
      return false;
    }
  }
}
