import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';


import '../core/constant.dart';

class HBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const HBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: backgroundColor2.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.deepOrange,
            offset: Offset(0, 20),
            blurRadius: 20,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildNavItem(icon: Iconsax.home_1, index: 0),
          buildNavItem(icon: Iconsax.heart, index: 1),
          buildNavItem(icon: Iconsax.shopping_bag, index: 2),
          buildNavItem(icon: Iconsax.user, index: 3),
        ],
      ),
    );
  }

  Widget buildNavItem({required IconData icon, required int index}) {
    final bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Icon(
          icon,
          size: 26,
          color: isSelected ? Colors.indigo : Colors.white70,
        ),
      ),
    );
  }
}