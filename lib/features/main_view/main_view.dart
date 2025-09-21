import 'package:bio_app/core/theming/app_colors.dart';
import 'package:flutter/material.dart';

import 'logic/home_navigation_controller.dart';
import 'presentation/widgets/home_nav_bar.dart';
import 'presentation/widgets/main_page_view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final controller = HomeNavigationController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      bottomNavigationBar: HomeNavBar(
        selectedIndex: controller.selectedIndex,
        onTap: (index) {
          controller.onItemTapped(index, () => setState(() {}));
        },
      ),
      body: MainPageView(
        controller: controller.pageController,
        onPageChanged: (index) {
          controller.onPageChanged(index, () => setState(() {}));
        },
      ),
    );
  }
}
