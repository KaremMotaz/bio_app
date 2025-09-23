import '../../../../../core/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/services/firebase_auth_service.dart';
import '../../../domain/auth_repo.dart';
import '../../../domain/user_entity.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required this.authRepo}) : super(LoginInitialState());

  final AuthRepo authRepo;

  Future<void> signinWithEmailAndPassword({
    required TextEditingController passwordController,
    required TextEditingController emailController,
  }) async {
    emit(LoginLoadingState());
    final result = await authRepo.signinWithEmailAndPassword(
      password: passwordController.text,
      email: emailController.text,
    );
    result.fold(
      (failure) {
        emit(LoginFailureState(message: failure.message));
      },
      (userEntity) {
        _handlePostLogin(userEntity);
      },
    );
  }

  Future<void> signinWithGoogle() async {
    emit(LoginLoadingState());
    final result = await authRepo.signinWithGoogle();
    result.fold(
      (failure) {
        emit(LoginFailureState(message: failure.message));
      },
      (userEntity) {
        _handlePostLogin(userEntity);
      },
    );
  }

  Future<void> signinWithFacebook() async {
    emit(LoginLoadingState());
    final result = await authRepo.signinWithFacebook();
    result.fold(
      (failure) {
        emit(LoginFailureState(message: failure.message));
      },
      (userEntity) {
        _handlePostLogin(userEntity);
      },
    );
  }

  Future<void> _handlePostLogin(UserEntity userEntity) async {
    try {
      await FirebaseAuthService.currentUser?.reload();
      final currentUser = FirebaseAuthService.currentUser;

      if (currentUser == null) {
        emit(
          LoginFailureState(
            message: "لم يتم العثور على بيانات المستخدم.",
          ),
        );
        return;
      }

      final result = await authRepo.showUserIsOldOrNot();
      bool oldStudent = false;

      result.fold(
        (failure) {
          emit(
            LoginFailureState(
              message: "لم يتم العثور على بيانات المستخدم.",
            ),
          );
          return;
        },
        (isOld) {
          oldStudent = isOld;
        },
      );

      if (state is LoginFailureState) return;

      // هل مسجل بحساب اجتماعي (جوجل/فيسبوك)؟
      final isSocialLogin = currentUser.providerData.any(
        (userInfo) => userInfo.providerId != 'password',
      );

      if (isSocialLogin || currentUser.emailVerified) {
        if (!oldStudent) {
          emit(
            LoginNavigateState(
              message: "تم تسجيل الدخول بنجاح.",
              route: Routes.fillProfileView,
            ),
          );
        } else {
          emit(
            LoginNavigateState(
              message: "تم تسجيل الدخول بنجاح.",
              route: Routes.mainView,
            ),
          );
        }
      } else {
        emit(
          LoginFailureState(
            message: "يرجى التحقق من بريدك الإلكتروني أولاً.",
          ),
        );
      }
    } catch (e) {
      emit(
        LoginFailureState(
          message:
              "تعذر إكمال تسجيل الدخول. تأكد من اتصالك بالإنترنت.",
        ),
      );
    }
  }
}
