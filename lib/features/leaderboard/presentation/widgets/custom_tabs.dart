import 'package:bio_app/core/theming/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../../core/theming/text_styles.dart';

class CustomTabs extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomTabs({
    super.key,
    required this.tabs,
    required TabController tabController,
  }) : _tabController = tabController;

  final List<String> tabs;
  final TabController _tabController;

  @override
  Size get preferredSize => const Size.fromHeight(36);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(tabs.length, (index) {
        final bool isSelected = _tabController.index == index;
        return GestureDetector(
          onTap: () => _tabController.animateTo(index),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              gradient: isSelected
                  ? const LinearGradient(
                      colors: [Color(0xfffe758c), Color(0xfffc7cab)],
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                    )
                  : null,
              color: isSelected ? null : AppColors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSelected
                    ? AppColors.transparent
                    : AppColors.grey300,
                width: .5,
              ),
            ),
            child: Text(
              tabs[index],
              style: TextStyles.semiBold15.copyWith(
                color: isSelected ? AppColors.white : AppColors.black,
              ),
            ),
          ),
        );
      }),
    );
  }
}
