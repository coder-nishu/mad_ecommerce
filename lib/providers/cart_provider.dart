import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  final List<String> _cartItems = List.generate(
    4,
        (index) => "Item ${index + 1}",
  );

  List<String> get cartItems => _cartItems;

  void removeItem(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
  }
}