import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../errors/auth_failure.dart';
import '../errors/failure.dart';
import '../errors/server_failure.dart';
import '../helpers/backend_endpoint.dart';
import '../helpers/get_user.dart';
import 'data_service.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  final FacebookAuth _facebookAuth = FacebookAuth.instance;
  static final currentUser = FirebaseAuth.instance.currentUser;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseService databaseService;

  FirebaseAuthService({required this.databaseService});

  // Sign up
  Future<Either<Failure, User>> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth
          .createUserWithEmailAndPassword(
            email: email,
            password: password,
          );
      return right(credential.user!);
    } on FirebaseAuthException catch (e) {
      return left(
        ServerFailure(
          code: e.code,
          message: e.message ?? 'Firebase error',
        ),
      );
    } catch (e) {
      return left(
        ServerFailure(code: 'unknown', message: e.toString()),
      );
    }
  }

  // Sign in with email/password
  Future<Either<Failure, User>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth
          .signInWithEmailAndPassword(
            email: email,
            password: password,
          );
      return right(credential.user!);
    } on FirebaseAuthException catch (e) {
      return left(
        ServerFailure(
          code: e.code,
          message: e.message ?? 'Firebase error',
        ),
      );
    } catch (e) {
      return left(
        ServerFailure(code: 'unknown', message: e.toString()),
      );
    }
  }

  // Google Sign-in
Future<Either<Failure, User>> signInWithGoogle({
  String? serverClientId,
}) async {
  try {
    if (serverClientId != null) {
      _googleSignIn.initialize(serverClientId: serverClientId);
    }
    final googleUser = await _googleSignIn.authenticate();

    final googleAuth = googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );

    final userCredential = await _firebaseAuth.signInWithCredential(
      credential,
    );
    return right(userCredential.user!);
  } on GoogleSignInException catch (e) {
    if (e.code == GoogleSignInExceptionCode.canceled) {
      return left(
        const ServerFailure(
          code: 'canceled',
          message: 'تم إلغاء تسجيل الدخول من قبل المستخدم',
        ),
      );
    }
    return left(
      ServerFailure(
        code: e.code.toString(),
        message: e.description ?? 'Google Sign-in error',
      ),
    );
  } on FirebaseAuthException catch (e) {
    return left(
      ServerFailure(
        code: e.code,
        message: e.message ?? 'Firebase error',
      ),
    );
  } catch (e) {
    return left(
      ServerFailure(code: 'unknown', message: e.toString()),
    );
  }
}

  // Facebook Sign-in
  Future<Either<Failure, User>> signinWithFacebook() async {
    try {
      final loginResult = await _facebookAuth.login();

      final credential = FacebookAuthProvider.credential(
        loginResult.accessToken!.tokenString,
      );

      final userCredential = await _firebaseAuth.signInWithCredential(
        credential,
      );
      return right(userCredential.user!);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'canceled') {
        return left(
          const ServerFailure(
            code: 'canceled',
            message: 'تم إلغاء تسجيل الدخول من قبل المستخدم',
          ),
        );
      }
      return left(
        ServerFailure(
          code: e.code,
          message: e.message ?? 'Firebase error',
        ),
      );
    } catch (e) {
      return left(
        ServerFailure(code: 'unknown', message: e.toString()),
      );
    }
  }

  Future<Either<Failure, void>> sendLinkToResetPassword({
    required String email,
  }) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return right(null);
    } on FirebaseAuthException catch (e) {
      return left(ServerFailure.fromFirebaseException(e));
    } on PlatformException catch (e) {
      return left(ServerFailure.fromPlatformException(e));
    } catch (e) {
      return left(ServerFailure.unknown(e.toString()));
    }
  }

  Future<Either<Failure, void>> sendEmailVerification() async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        return left(
          const ServerFailure(
            message: "No user is currently logged in.",
          ),
        );
      }
      await user.sendEmailVerification();
      return right(null);
    } on FirebaseAuthException catch (e) {
      return left(ServerFailure.fromFirebaseException(e));
    } on PlatformException catch (e) {
      return left(ServerFailure.fromPlatformException(e));
    } catch (e) {
      return left(ServerFailure.unknown(e.toString()));
    }
  }

  // Logout
  Future<void> logOut() async {
    await _googleSignIn.signOut();
    await _facebookAuth.logOut();
    await _firebaseAuth.signOut();
  }

  bool isLoggedIn() => _firebaseAuth.currentUser != null;

  // Delete Account with robust error handling
  Future<Either<Failure, Unit>> deleteAccount({
    String? password,
  }) async {
    final user = _firebaseAuth.currentUser;
    if (user == null) {
      return left(
        const ServerFailure(
          code: 'no-user',
          message: 'لا يوجد مستخدم مسجل الدخول حالياً.',
        ),
      );
    }

    try {
      final providerId = user.providerData.isNotEmpty
          ? user.providerData.first.providerId
          : null;

      if (providerId == 'password') {
        if (user.email == null || password == null) {
          return left(
            const ServerFailure(
              code: 'missing-credentials',
              message: 'البريد الإلكتروني وكلمة المرور مطلوبة.',
            ),
          );
        }
        final credential = EmailAuthProvider.credential(
          email: user.email!,
          password: password,
        );
        await user.reauthenticateWithCredential(credential);
      } else if (providerId == 'google.com') {
        final googleUser = await _googleSignIn.authenticate();
        final googleAuth = googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
        );
        await user.reauthenticateWithCredential(credential);
      } else if (providerId == 'facebook.com') {
        final fbLogin = await _facebookAuth.login();
        if (fbLogin.status != LoginStatus.success) {
          return left(
            const ServerFailure(
              code: 'cancelled',
              message: 'تم إلغاء تسجيل الدخول بواسطة فيسبوك.',
            ),
          );
        }
        final credential = FacebookAuthProvider.credential(
          fbLogin.accessToken!.tokenString,
        );
        await user.reauthenticateWithCredential(credential);
      } else {
        return left(
          const ServerFailure(
            code: 'unsupported-provider',
            message: 'المزود غير مدعوم لإعادة التحقق.',
          ),
        );
      }
      final String uId = getUser().uid!;
      await user.delete();

      await databaseService.deleteData(
        path: '${BackendEndpoint.deleteUser}/$uId',
      );
      await databaseService.deleteData(
        path:
            '${BackendEndpoint.deleteUser}/$uId/${BackendEndpoint.getExamsResults}',
      );
      await databaseService.deleteData(
        path:
            '${BackendEndpoint.deleteUser}/$uId/${BackendEndpoint.markExamAsOpened}',
      );
      await deleteUserExamsResult();

      return right(unit);
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'invalid-credential':
          message = 'كلمة المرور غير صحيحة.';
          break;
        case 'user-not-found':
          message = 'المستخدم غير موجود.';
          break;
        case 'requires-recent-login':
          message = 'يرجى تسجيل الدخول مرة أخرى قبل حذف الحساب.';
          break;
        default:
          message = e.message ?? 'حدث خطأ في المصادقة.';
      }
      return left(ServerFailure(code: e.code, message: message));
    } catch (e) {
      return left(
        ServerFailure(
          code: 'unknown',
          message: 'حدث خطأ غير معروف: ${e.toString()}',
        ),
      );
    }
  }

  Future<Either<Failure, Unit>> deleteUserExamsResult() async {
    final String uId = getUser().uid!;

    try {
      final exams = await databaseService.getData(
        path: BackendEndpoint.getExams,
      );

      if (exams == null) return right(unit);

      for (final exam in exams) {
        final examId = exam['id'];

        final userResult = await databaseService.getData(
          path:
              "${BackendEndpoint.getExams}/$examId/${BackendEndpoint.getExamResults}/$uId",
        );

        if (userResult != null) {
          await databaseService.deleteData(
            path:
                "${BackendEndpoint.getExams}/$examId/${BackendEndpoint.getExamResults}/$uId",
          );
        }
      }

      return right(unit);
    } catch (e) {
      return left(AuthFailure(message: e.toString()));
    }
  }
}
