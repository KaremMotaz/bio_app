import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:bio_app/core/routing/routes.dart';
import 'package:bio_app/features/auth/presentation/views/login_view.dart';
import 'package:bio_app/features/auth/presentation/views/otp_verification_view.dart';
import 'package:bio_app/features/auth/presentation/views/reset_password_view.dart';
import 'package:bio_app/features/auth/presentation/views/signup_view.dart';
import 'package:bio_app/features/mainPageView/main_view.dart';
import 'package:bio_app/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:bio_app/features/profile/presentation/views/profile_view.dart';
import 'package:bio_app/features/quiz/data/repos/questions_repo_imp.dart';
import 'package:bio_app/features/quiz/domain/logic/answer_evaluator.dart';
import 'package:bio_app/features/quiz/domain/logic/quiz_timer.dart';
import 'package:bio_app/features/quiz/presentation/manager/quiz_cubit/quiz_cubit.dart';
import 'package:bio_app/features/quiz/presentation/views/quiz_view.dart';

abstract class AppRouter {
  static GoRouter createRouter(bool hasSeenOnboarding) {
    final initialPath = hasSeenOnboarding
        ? Routes.signInView
        : Routes.onBoardingView;
    return GoRouter(
      initialLocation: initialPath,
      routes: [
        GoRoute(
          path: Routes.onBoardingView,
          builder: (context, state) => const OnboardingView(),
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
          builder: (context, state) => const ResetPasswordView(),
        ),
        GoRoute(
          path: Routes.oTPVerificationView,
          builder: (context, state) => const OtpVerificationView(),
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
      ],
    );
  }
}
