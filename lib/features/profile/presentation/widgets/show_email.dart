import '../../../../core/helpers/get_user.dart';
import '../../../../core/theming/assets_data.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../settings/presentation/widgets/settings_list_tile.dart';
import 'package:flutter/material.dart';

class ShowEmail extends StatelessWidget {
  const ShowEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsListTile(
      title: "البريد الإلكتروني",
      icon: AssetsData.emailIcon,
      subTitle: Text(
        getUser().email ?? "",
        style: TextStyles.medium12,
      ),
      onTap: () {},
    );
  }
}
