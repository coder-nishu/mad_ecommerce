import 'package:flutter/material.dart';

class ProductDetailProvider extends ChangeNotifier {
  final PageController pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  int get currentPage => _currentPage;

  void setPage(int index) {
    int pageDifference = (index - _currentPage).abs();
    _currentPage = index;
    if (pageDifference > 1) {
      pageController.jumpToPage(index);
    } else {
      pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
    notifyListeners();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}