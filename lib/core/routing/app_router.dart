import 'package:bio_app/features/exam/domain/usecases/submit_exam_usecase.dart'
    show SubmitExamUseCase;
import 'package:bio_app/features/exam/presentation/manager/exam_cubit/exam_cubit.dart';
import 'package:bio_app/features/exam/presentation/views/exam_view.dart';
import 'package:bio_app/features/exam/presentation/views/exam_result_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/views/fill_profile_view.dart';
import '../../features/auth/presentation/views/otp_verification_view.dart';
import '../../features/auth/presentation/views/reset_password_view.dart';
import '../../features/auth/presentation/views/signin_view.dart';
import '../../features/auth/presentation/views/signup_view.dart';
import '../../features/exam/data/datasources/exam_remote_data_source.dart';
import '../../features/exam/data/repos/exam_repo_impl.dart';
import '../../features/exam/domain/usecases/get_exam_usecase.dart';
import '../../features/mainPageView/main_view.dart';
import '../../features/onboarding/presentation/views/onboarding_view.dart';
import '../../features/profile/presentation/views/profile_view.dart';
import '../../features/quiz/data/repos/questions_repo_imp.dart';
import '../../features/quiz/domain/logic/answer_evaluator.dart';
import '../../features/quiz/domain/logic/quiz_timer.dart';
import '../../features/quiz/presentation/manager/quiz_cubit/quiz_cubit.dart';
import '../../features/quiz/presentation/views/quiz_view.dart';
import '../helpers/constants.dart';
import '../services/cache_helper.dart';
import '../services/firebase_auth_service.dart';
import 'routes.dart';

abstract class AppRouter {
  static GoRouter createRouter() {
    final bool hasSeenOnboarding = CacheHelper.getBool(
      key: kHasSeenOnboarding,
    );
    final bool isLoggedIn = FirebaseAuthService()
        .isLoggedIn();
    final String initialPath = isLoggedIn
        ? Routes.mainView
        : hasSeenOnboarding
        ? Routes.signInView
        : Routes.onBoardingView;

    return GoRouter(
      initialLocation: initialPath,
      routes: [
        GoRoute(
          path: Routes.onBoardingView,
          builder: (context, state) =>
              const OnboardingView(),
        ),

        GoRoute(
          path: Routes.signInView,
          builder: (context, state) => const LoginView(),
        ),
        GoRoute(
          path: Routes.signUpView,
          builder: (context, state) => const SignupView(),
        ),
        GoRoute(
          path: Routes.forgotPasswordView,
          builder: (context, state) =>
              const ResetPasswordView(),
        ),
        GoRoute(
          path: Routes.otpVerificationView,
          builder: (context, state) =>
              const OtpVerificationView(),
        ),
        GoRoute(
          path: Routes.fillProfileView,
          builder: (context, state) =>
              const FillProfileView(),
        ),
        GoRoute(
          path: Routes.mainView,
          builder: (context, state) => const MainView(),
        ),
        GoRoute(
          path: Routes.profileView,
          builder: (context, state) => const ProfileView(),
        ),
        GoRoute(
          path: Routes.examResultView,
          builder: (context, state) =>
              const ExamResultView(),
        ),
        GoRoute(
          path: Routes.quizView,
          builder: (context, state) => BlocProvider(
            create: (context) => QuizCubit(
              QuizTimer(),
              AnswerEvaluator(),
              questionsRepo: QuestionsRepoImp(),
            )..loadQuestions(),
            child: const QuizView(),
          ),
        ),
        GoRoute(
          path: Routes.examView,
          builder: (context, state) => BlocProvider(
            create: (context) => ExamCubit(
              getExamUseCase: GetExamUseCase(
                examRepo: ExamRepoImpl(
                  examRemoteDataSource:
                      ExamRemoteDataSource(
                        firestore:
                            FirebaseFirestore.instance,
                      ),
                ),
              ),
              submitExamUseCase: SubmitExamUseCase(
                examRepo: ExamRepoImpl(
                  examRemoteDataSource:
                      ExamRemoteDataSource(
                        firestore:
                            FirebaseFirestore.instance,
                      ),
                ),
              ),
            )..loadExam("0"),
            child: const ExamView(),
          ),
        ),
      ],
    );
  }
}
