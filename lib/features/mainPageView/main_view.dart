import 'package:flutter/material.dart';

import 'logic/home_navigation_controller.dart';
import 'presentation/views/main_page_view.dart';
import 'widgets/home_nav_bar.dart';

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
      backgroundColor: Colors.white,
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
