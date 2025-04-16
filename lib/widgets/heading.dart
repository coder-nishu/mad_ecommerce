import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HHeading extends StatelessWidget {
  const HHeading({
    super.key,
    required this.title,
    this.isSeeAll = true,
    this.titleFontSize = 24,
    this.onPressed,
    this.icon = Icons.flash_on, // Default icon is flash_on, but it can be customized
    this.iconColor = Colors.deepOrange, // Default color for the icon
    this.iconSize = 24, // Default size for the icon
  });

  final String title;
  final bool isSeeAll;
  final double titleFontSize;
  final void Function()? onPressed;
  final IconData icon; // New parameter for custom icon
  final Color iconColor; // Color for the icon
  final double iconSize; // Size for the icon

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          textAlign: TextAlign.start,
          style: GoogleFonts.quicksand(
            fontSize: titleFontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 8), // Add some spacing between the title and the icon
        Icon(
          icon, // Use the passed icon
          color: iconColor, // Use the passed icon color
          size: iconSize, // Use the passed icon size
        ),
        const Spacer(),
        if (isSeeAll)
          TextButton(
            onPressed: onPressed,
            child: Text(
              'See All',
              style: GoogleFonts.quicksand(
                fontSize: 14,
                color: Colors.deepOrange,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
      ],
    );
  }
}
