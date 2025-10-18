import 'package:flutter/material.dart';
import 'package:my_abans/models/cart_model.dart';

class CartProvider extends ChangeNotifier {
  List<CartModel> _cartItems = [];
  List<CartModel> get cartItems => _cartItems;

  void addToCart(CartModel cartItem) {
    final index = _cartItems.indexWhere(
      (item) => item.product.id == cartItem.product.id,
    );
    if (index != -1) {
      _cartItems[index].quantity = cartItem.quantity;
      notifyListeners();
    } else {
      _cartItems.add(cartItem);
      notifyListeners();
    }
  }
}
