import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      elevation: 4,
      shadowColor: Colors.black,
      toolbarHeight: 130,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Shop Smart with EzzyShop',
                style: GoogleFonts.quicksand(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              badges.Badge(
                badgeContent: Text(
                  '1',
                  style: GoogleFonts.quicksand(color: Colors.white),
                ),
                position: badges.BadgePosition.topEnd(end: -6, top: -9),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(350),
                    // borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Icon(
                    FontAwesomeIcons.bell,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search your daily accesories',
                hintStyle: GoogleFonts.quicksand(
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                  fontSize: 17,
                ),
                prefixIcon: Icon(
                  FontAwesomeIcons.magnifyingGlass,
                  color: Colors.deepOrange,
                ),
                suffixIcon: Icon(Icons.tune, color: Colors.deepOrange),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
      backgroundColor: Colors.deepOrange,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(130);
}
