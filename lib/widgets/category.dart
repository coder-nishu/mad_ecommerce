import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../routers/app_routers.dart';

class HCategory extends StatelessWidget {
  const HCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CategoryItem(imagePath: 'assets/shirt.png', label: 'Cloth'),
            CategoryItem(imagePath: 'assets/watch.png', label: 'Watch'),
            CategoryItem(imagePath: 'assets/headphn.png', label: 'Headphones'),
            CategoryItem(imagePath: 'assets/gift.png', label: 'Gift'),
          ],
        ),
      ],
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String imagePath;
  final String label;

  const CategoryItem({super.key, required this.imagePath, required this.label});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      splashColor: Colors.deepOrange.withAlpha(50),
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.category, arguments: label);
      },
      child: Column(
        children: [
          CircleAvatar(
            radius: 35,
            backgroundColor: Colors.grey.withAlpha(50),
            child: Image.asset(
              imagePath,
              height: 38,
              fit: BoxFit.contain,
              color: Colors.deepOrange,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.quicksand(
              fontSize: 14,
              color: Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
