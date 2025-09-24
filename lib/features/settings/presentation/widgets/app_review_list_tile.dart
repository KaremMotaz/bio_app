import '../../../../core/services/get_it_service.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/assets_data.dart';
import '../../data/settings_repo.dart';
import '../manager/app_rating_cubit/app_rating_cubit.dart';
import 'app_rating_consumer.dart';
import 'settings_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppReviewListTile extends StatelessWidget {
  const AppReviewListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AppRatingCubit(settingsRepo: getIt<SettingsRepo>()),
      child: Builder(
        builder: (context) {
          return SettingsListTile(
            title: "اكتب تقييماً",
            icon: AssetsData.appEvaluationIcon,
            onTap: () {
              final cubit = context.read<AppRatingCubit>();
              showDialog(
                context: context,
                builder: (context) {
                  return BlocProvider.value(
                    value: cubit,
                    child: const Dialog(
                      clipBehavior: Clip.hardEdge,
                      elevation: 2,
                      insetPadding: EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      backgroundColor: AppColors.white,
                      child: AppRatingConsumer(),
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
