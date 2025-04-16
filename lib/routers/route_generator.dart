import 'package:flutter/material.dart';

import '../model/product_model.dart';
import '../views/all_product_page.dart';
import '../views/category_product_page.dart';
import '../views/checkout_page.dart';
import '../views/home_page.dart';
import '../views/login_page.dart';
import '../views/product_detail_page.dart';
import '../views/signup_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) =>  HomePage());

      case '/product_detail':
        Product product = settings.arguments as Product;
        return MaterialPageRoute(
          builder: (_) => ProductDetailPage(product: product),
        );

      case '/signup':
        return MaterialPageRoute(builder: (_) => const SignUpPage());

      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginPage());

      case '/checkout':
        return MaterialPageRoute(builder: (_) => const CheckoutPage());

      case '/category':
        String category = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => CategoryProductsPage(category: category),
        );

      case '/all_products':
        return MaterialPageRoute(builder: (_) => const AllProductPage());

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(body: Center(child: Text("Page not found!"))),
    );
  }
}
