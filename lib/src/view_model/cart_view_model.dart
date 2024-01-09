import 'package:flutter/material.dart';

class CartViewModel with ChangeNotifier {
  double totalPrice = 0;
  void setTotalPrice(List<Map<String, dynamic>> carts) {
    totalPrice = 0;

    for (Map<String, dynamic> cartItem in carts) {
      // totalPrice += cartItem['price'] * cartItem['quantity'];
      totalPrice += cartItem['price'];
    }
  }
}
