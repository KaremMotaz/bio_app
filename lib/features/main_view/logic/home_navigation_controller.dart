import 'package:flutter/material.dart';

class HomeNavigationController {
  int selectedIndex = 0;
  final PageController pageController = PageController();

  void dispose() {
    pageController.dispose();
  }

  void onItemTapped(int index, VoidCallback updateUI) {
    selectedIndex = index;
    updateUI();
    pageController.jumpToPage(index);
  }

  void onPageChanged(int index, VoidCallback updateUI) {
    selectedIndex = index;
    updateUI();
  }
}
