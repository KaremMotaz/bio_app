import 'package:bio_app/core/widgets/no_internet_view.dart';
import 'package:bio_app/features/splash/presentation/splash_view.dart';
import 'package:bio_app/features/units/presentation/notifications_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/views/fill_profile_view.dart';
import '../../features/auth/presentation/views/login_view.dart';
import '../../features/auth/presentation/views/otp_verification_view.dart';
import '../../features/auth/presentation/views/reset_password_view.dart';
import '../../features/auth/presentation/views/signup_view.dart';
import '../../features/chapters/data/repos/chapter_repo_imp.dart';
import '../../features/chapters/domain/chapter_entity.dart';
import '../../features/chapters/presentation/chapter_view.dart';
import '../../features/chapters/presentation/manager/chapter_cubit/chapter_cubit.dart';
import '../../features/exam/data/repos/exam_questions_repo_impl.dart';
import '../../features/exam/data/repos/exam_repo_impl.dart';
import '../../features/exam/domain/entities/exam_entity.dart';
import '../../features/exam/presentation/manager/exam_questions_cubit/exam_questions_cubit.dart';
import '../../features/exam/presentation/views/exam_questions_view.dart';
import '../../features/exam_result/data/repos/exam_result_repo_imp.dart';
import '../../features/exam_result/presentation/manager/exam_result_cubit/exam_result_cubit.dart';
import '../../features/exam_result/presentation/views/exam_result_details_view.dart';
import '../../features/exam_result/presentation/views/exam_result_view.dart';
import '../../features/lessons/data/repos/lesson_repo_imp.dart';
import '../../features/lessons/domain/quiz_entity.dart';
import '../../features/lessons/presentation/lessons_view.dart';
import '../../features/lessons/presentation/manager/lesson_cubit/lesson_cubit.dart';
import '../../features/lessons/presentation/quiz_ready_view.dart';
import '../../features/main_view/main_view.dart';
import '../../features/onboarding/presentation/views/onboarding_view.dart';
import '../../features/profile/data/repos/user_data_repo_imp.dart';
import '../../features/profile/domain/repos/images_repo.dart';
import '../../features/profile/presentation/manager/change_profile_image_cubit/change_profile_image_cubit.dart';
import '../../features/profile/presentation/manager/edit_profile_cubit/edit_profile_cubit.dart';
import '../../features/profile/presentation/views/profile_view.dart';
import '../../features/quiz_questions/data/repos/quiz_questions_repo_imp.dart';
import '../../features/quiz_questions/domain/helper/quiz_helpers.dart';
import '../../features/quiz_questions/presentation/manager/quiz_questions_cubit/quiz_questions_cubit.dart';
import '../../features/quiz_questions/presentation/views/quiz_questions_view.dart';
import '../../features/units/domain/unit_entity.dart';
import '../services/get_it_service.dart';
import 'routes.dart';

abstract class AppRouter {
  static GoRouter createRouter({required bool isConnected}) {
    return GoRouter(
      routes: [
        GoRoute(
          path: Routes.splashView,
          builder: (context, state) {
            return const SplashView();
          },
        ),
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
          path: Routes.notificationsView,
          builder: (context, state) {
            return const NotificationsView();
          },
        ),
        GoRoute(
          path: Routes.noInternetView,
          builder: (context, state) =>
              NoInternetView(isConnected: isConnected),
        ),
        GoRoute(
          path: Routes.profileView,
          builder: (context, state) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => EditProfileCubit(
                    userDataRepoImp: getIt<UserDataRepoImp>(),
                  ),
                ),
                BlocProvider(
                  create: (context) => ChangeProfileImageCubit(
                    imagesRepo: getIt<ImagesRepo>(),
                  ),
                ),
              ],
              child: const ProfileView(),
            );
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
              child: const QuizQuestionsView(),
            );
          },
        ),
        GoRoute(
          path: Routes.examQuestionsView,
          builder: (context, state) {
            final args =
                GoRouterState.of(context).extra
                    as Map<String, dynamic>;
            final String examId = args['examId'];
            final int examIndex = args['examIndex'];
            final List<ExamEntity> exams = args['exams'];
            return BlocProvider(
              create: (_) =>
                  ExamQuestionsCubit(
                    examQuestionsRepoImpl:
                        getIt<ExamQuestionsRepoImp>(),
                  )..getExamQuestions(
                    examId: examId,
                    examIndex: examIndex,
                    exams: exams,
                  ),
              child: ExamQuestionsView(
                examIndex: examIndex,
                examId: examId,
              ),
            );
          },
        ),
        GoRoute(
          path: Routes.examResultView,
          builder: (context, state) {
            final args =
                GoRouterState.of(context).extra
                    as Map<String, dynamic>;
            final String examId = args['examId'];
            final int resultExamIndex = args['resultExamIndex'];
            return BlocProvider(
              create: (_) =>
                  ExamResultCubit(
                    examResultRepo: getIt<ExamResultRepoImp>(),
                    examRepo: getIt<ExamRepoImpl>(),
                  )..getResult(
                    examId: examId,
                    resultExamIndex: resultExamIndex,
                  ),
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
            final UnitEntity unit = state.extra as UnitEntity;
            return BlocProvider(
              create: (context) => ChapterCubit(
                chapterRepoImpl: getIt<ChapterRepoImpl>(),
              )..getChapters(unitId: unit.id),
              child: ChapterView(unit: unit),
            );
          },
        ),
        GoRoute(
          path: Routes.lessonsView,
          builder: (context, state) {
            final args =
                GoRouterState.of(context).extra
                    as Map<String, dynamic>;
            final ChapterEntity chapter = args['chapter'];
            final String unitId = args['unitId'];

            return BlocProvider(
              create: (context) => LessonCubit(
                lessonRepoImp: getIt<LessonRepoImp>(),
              )..getLessons(chapterId: chapter.id, unitId: unitId),
              child: LessonsView(chapter: chapter),
            );
          },
        ),
        GoRoute(
          path: Routes.quizReadyView,
          builder: (context, state) {
            final QuizEntity quiz = state.extra as QuizEntity;
            return QuizReadyView(quiz: quiz);
          },
        ),
      ],
      redirect: (context, state) {
        String? lastLocation;

        final currentLocation = state.uri.toString();

        if (!isConnected &&
            currentLocation != Routes.noInternetView) {
          lastLocation = currentLocation;
          return Routes.noInternetView;
        }

        if (isConnected && currentLocation == Routes.noInternetView) {
          return lastLocation ?? Routes.mainView;
        }

        return null;
      },
    );
  }
}
