import 'package:ecommerce/providers/bottom_nav_provider.dart';
import 'package:ecommerce/providers/category_product_provider.dart';
import 'package:ecommerce/views/cart_page.dart';
import 'package:ecommerce/views/home_page.dart';
import 'package:ecommerce/views/profile_page.dart';
import 'package:ecommerce/views/wish_list_page.dart';
import 'package:ecommerce/widgets/bottom_nav.dart';
import 'package:flutter/material.dart';
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
