import '../../features/chapters/data/repos/chapter_repo_imp.dart';
import '../../features/chapters/presentation/manager/chapter_cubit/chapter_cubit.dart';
import '../../features/lessons/data/repos/lesson_repo_imp.dart';
import '../../features/lessons/presentation/manager/lesson_cubit/lesson_cubit.dart';
import '../../features/lessons/presentation/quiz_ready_view.dart';
import '../../features/quiz_questions/domain/logic/quiz_helpers.dart';
import '../services/get_it_service.dart';
import '../../features/exam/domain/usecases/get_exam_usecase.dart';
import '../../features/exam/domain/usecases/submit_exam_usecase.dart';
import '../../features/exam_result/data/repos/exam_result_repo_imp.dart';
import '../../features/quiz_questions/data/repos/quiz_questions_repo_imp.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../helpers/constants.dart';
import '../services/cache_helper.dart';
import '../services/firebase_auth_service.dart';
import 'routes.dart';
import '../../features/onboarding/presentation/views/onboarding_view.dart';
import '../../features/auth/presentation/views/fill_profile_view.dart';
import '../../features/auth/presentation/views/otp_verification_view.dart';
import '../../features/auth/presentation/views/reset_password_view.dart';
import '../../features/auth/presentation/views/signin_view.dart';
import '../../features/auth/presentation/views/signup_view.dart';
import '../../features/main_view/main_view.dart';
import '../../features/profile/presentation/views/profile_view.dart';
import '../../features/exam_result/presentation/views/exam_result_view.dart';
import '../../features/exam_result/presentation/views/exam_result_details_view.dart';
import '../../features/exam_result/presentation/manager/exam_result_cubit/exam_result_cubit.dart';
import '../../features/quiz_questions/presentation/views/quiz_view.dart';
import '../../features/quiz_questions/presentation/manager/quiz_questions_cubit/quiz_questions_cubit.dart';
import '../../features/chapters/presentation/chapter_view.dart';
import '../../features/lessons/presentation/lessons_view.dart';
import '../../features/exam/presentation/views/exam_view.dart';
import '../../features/exam/presentation/manager/exam_cubit/exam_cubit.dart';

abstract class AppRouter {
  static GoRouter createRouter() {
    final bool hasSeenOnboarding = CacheHelper.getBool(
      key: kHasSeenOnboarding,
    );
    final bool isLoggedIn = getIt<FirebaseAuthService>().isLoggedIn();

    final String initialPath;
    if (isLoggedIn) {
      initialPath = Routes.mainView;
    } else if (hasSeenOnboarding) {
      initialPath = Routes.signInView;
    } else {
      initialPath = Routes.onBoardingView;
    }

    return GoRouter(
      initialLocation: initialPath,
      routes: [
        GoRoute(
          path: Routes.onBoardingView,
          builder: (context, state) {
            return const OnboardingView();
          },
        ),
        GoRoute(
          path: Routes.signInView,
          builder: (context, state) {
            return const LoginView();
          },
        ),
        GoRoute(
          path: Routes.signUpView,
          builder: (context, state) {
            return const SignupView();
          },
        ),
        GoRoute(
          path: Routes.forgotPasswordView,
          builder: (context, state) {
            return const ResetPasswordView();
          },
        ),
        GoRoute(
          path: Routes.otpVerificationView,
          builder: (context, state) {
            return const OtpVerificationView();
          },
        ),
        GoRoute(
          path: Routes.fillProfileView,
          builder: (context, state) {
            return const FillProfileView();
          },
        ),
        GoRoute(
          path: Routes.mainView,
          builder: (context, state) {
            return const MainView();
          },
        ),
        GoRoute(
          path: Routes.profileView,
          builder: (context, state) {
            return const ProfileView();
          },
        ),
        GoRoute(
          path: Routes.quizView,
          builder: (context, state) {
            final String quizId = state.extra as String;
            return BlocProvider(
              create: (_) => QuizQuestionsCubit(
                getIt<QuizHelper>(),
                getIt<QuizHelper>(),
                questionsRepo: getIt<QuizQuestionsRepoImp>(),
              )..loadQuestions(quizId: quizId),
              child: const QuizView(),
            );
          },
        ),
        GoRoute(
          path: Routes.examView,
          builder: (context, state) {
            return BlocProvider(
              create: (_) => ExamCubit(
                getExamUseCase: getIt<GetExamUseCase>(),
                submitExamUseCase: getIt<SubmitExamUseCase>(),
              )..loadExam("0"),
              child: const ExamView(),
            );
          },
        ),
        GoRoute(
          path: Routes.examResultView,
          builder: (context, state) {
            return BlocProvider(
              create: (_) => ExamResultCubit(
                getExamUseCase: getIt<GetExamUseCase>(),
                examResultRepo: getIt<ExamResultRepoImpl>(),
              )..getResult(examId: 0),
              child: const ExamResultView(),
            );
          },
        ),
        GoRoute(
          path: Routes.examResultDetailsView,
          builder: (context, state) {
            final cubit = state.extra as ExamResultCubit;
            return BlocProvider.value(
              value: cubit,
              child: const ExamResultDetailsView(),
            );
          },
        ),
        GoRoute(
          path: Routes.chaptersView,
          builder: (context, state) {
            final String unitId = state.extra as String;
            return BlocProvider(
              create: (context) => ChapterCubit(
                chapterRepoImpl: getIt<ChapterRepoImpl>(),
              )..getChapters(unitId: unitId),
              child: const ChapterView(),
            );
          },
        ),
        GoRoute(
          path: Routes.lessonsView,
          builder: (context, state) {
            final String chapterId = state.extra as String;
            final String unitId = state.extra as String;
            return BlocProvider(
              create: (context) => LessonCubit(
                lessonRepoImp: getIt<LessonRepoImp>(),
              )..getLessons(chapterId: chapterId, unitId: unitId),
              child: const LessonsView(),
            );
          },
        ),
        GoRoute(
          path: Routes.quizReadyView,
          builder: (context, state) {
            final int quizId = state.extra as int;
            return QuizReadyView(quizId: quizId);
          },
        ),
      ],
    );
  }
}
