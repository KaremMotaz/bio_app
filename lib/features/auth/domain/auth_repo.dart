import 'package:dartz/dartz.dart';

import '../../../core/errors/failure.dart';
import 'user_entity.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserEntity>> signupWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Either<Failure, UserEntity>> signinWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Either<Failure, UserEntity>> signinWithGoogle();

  Future<Either<Failure, UserEntity>> signinWithFacebook();
  Future<Either<Failure, Unit>> sendLinkToResetPassword({
    required String email,
  });
  Future<Either<Failure, Unit>> sendEmailVerification();
  Future<Either<Failure, Unit>> logOut();
  Future<Either<Failure, UserEntity>> addUserData({
    required UserEntity userEntity,
  });
  Future saveUserData({required UserEntity userEntity});
  Future<UserEntity> getUserData({required String uid});
  Future<Either<Failure, Unit>> deleteAccount({String? password});
  Future<Either<Failure, bool>> checkIfDataExists({required String documentId});
  Future<Either<Failure, bool>> showUserIsOldOrNot();
}
