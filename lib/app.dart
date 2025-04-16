import 'package:flutter/material.dart';
import 'package:mad_ecommerce/providers/bottom_nav_provider.dart';
import 'package:mad_ecommerce/views/cart_page.dart';
import 'package:mad_ecommerce/views/home_page.dart';
import 'package:mad_ecommerce/views/profile_page.dart';
import 'package:mad_ecommerce/views/wish_list%20page.dart';
import 'package:mad_ecommerce/widgets/bottom_nav.dart';
import 'package:provider/provider.dart';

class EzzyShopSpp extends StatefulWidget {
  const EzzyShopSpp({super.key});

  static final List<Widget> pages = [
    HomePage(),
    WishListPage(),
    CartPage(),
    ProfilePage(),
  ];

  @override
  State<EzzyShopSpp> createState() => _EzzyShopSppState();
}

class _EzzyShopSppState extends State<EzzyShopSpp> {

  @override
  Widget build(BuildContext context) {
    final bottomNavProvider = Provider.of<BottomNavProvider>(context);

    return Scaffold(
      body: IndexedStack(
        index: bottomNavProvider.selectedIndex,
        children: EzzyShopSpp.pages,
      ),
      bottomNavigationBar: HBottomNavBar(
        selectedIndex: bottomNavProvider.selectedIndex,
        onItemTapped: bottomNavProvider.updateIndex,
      ),
    );
  }
}
