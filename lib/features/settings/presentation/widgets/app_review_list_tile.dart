import 'package:bio_app/core/services/get_it_service.dart';
import 'package:bio_app/core/theming/app_colors.dart';
import 'package:bio_app/core/theming/assets_data.dart';
import 'package:bio_app/features/settings/data/settings_repo.dart';
import 'package:bio_app/features/settings/presentation/manager/review_app_cubit/review_app_cubit.dart';
import 'package:bio_app/features/settings/presentation/widgets/app_review_listener.dart';
import 'package:bio_app/features/settings/presentation/widgets/settings_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppReviewListTile extends StatelessWidget {
  const AppReviewListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ReviewAppCubit(settingsRepo: getIt<SettingsRepo>()),
      child: Builder(
        builder: (context) {
          return SettingsListTile(
            title: "اكتب تقييماً",
            icon: AssetsData.appEvaluationIcon,
            onTap: () {
              final cubit = context.read<ReviewAppCubit>();
              showDialog(
                context: context,
                builder: (context) {
                  return BlocProvider.value(
                    value: cubit,
                    child: const Dialog(
                      clipBehavior: Clip.hardEdge,
                      backgroundColor: AppColors.white,
                      child: AppReviewListener(),
                    ),
                  );
                },
              );
            },
            isTrailingIcon: true,
          );
        },
      ),
    );
  }
}
