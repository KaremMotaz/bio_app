import '../../../core/helpers/constants.dart';
import '../../../core/routing/routes.dart';
import '../../../core/services/cache_helper.dart';
import '../../../core/services/firebase_auth_service.dart';
import '../../../core/services/get_it_service.dart';
import '../../../core/theming/app_colors.dart';
import '../../../core/theming/assets_data.dart';
import '../../../core/theming/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  bool showWord = false;
  bool showTi = false;
  bool showCs = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) setState(() => showWord = true);
    });

    Future.delayed(const Duration(milliseconds: 1000), () {
      if (mounted) setState(() => showTi = true);
    });

    Future.delayed(const Duration(milliseconds: 1800), () {
      if (mounted) setState(() => showCs = true);

      Future.delayed(const Duration(milliseconds: 600), () {
        if (!mounted) return;

        final bool hasSeenOnboarding = CacheHelper.getBool(
          key: kHasSeenOnboarding,
        );
        final bool isLoggedIn = getIt<FirebaseAuthService>()
            .isLoggedIn();

        if (isLoggedIn) {
          GoRouter.of(context).pushReplacement(Routes.mainView);
        } else if (hasSeenOnboarding) {
          GoRouter.of(context).pushReplacement(Routes.signInView);
        } else {
          GoRouter.of(context).pushReplacement(Routes.onBoardingView);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final baseStyle = TextStyles.bold22.copyWith(
      fontFamily: "Rockwell",
    );

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AssetsData.splashLogo,
              width: 100,
              colorFilter: const ColorFilter.mode(
                AppColors.mainBlue,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              textDirection: TextDirection.ltr,
              children: [
                AnimatedSlide(
                  offset: showWord
                      ? Offset.zero
                      : const Offset(0, 10),
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeOut,
                  child: AnimatedOpacity(
                    opacity: showWord ? 1 : 0,
                    duration: const Duration(milliseconds: 600),
                    child: Text('Bio', style: baseStyle),
                  ),
                ),
                AnimatedSlide(
                  offset: showTi ? Offset.zero : const Offset(0, 10),
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeOut,
                  child: AnimatedOpacity(
                    opacity: showTi ? 1 : 0,
                    duration: const Duration(milliseconds: 600),
                    child: Text(
                      'ti',
                      style: baseStyle.copyWith(
                        color: AppColors.mainBlue,
                      ),
                    ),
                  ),
                ),
                AnimatedSlide(
                  offset: showWord
                      ? Offset.zero
                      : const Offset(0, 10),
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeOut,
                  child: AnimatedOpacity(
                    opacity: showWord ? 1 : 0,
                    duration: const Duration(milliseconds: 600),
                    child: Text('cs', style: baseStyle),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
