import 'package:flutter/material.dart';
import 'package:my_abans/models/cart_model.dart';
import 'package:my_abans/providers/product_provider.dart';
import 'package:provider/provider.dart';

class CartProvider extends ChangeNotifier {
  final List<CartModel> _cartItems = [];
  List<CartModel> get cartItems => _cartItems;

  TextEditingController _nameController = TextEditingController();
  TextEditingController get nameController => _nameController;
  TextEditingController _addressController = TextEditingController();
  TextEditingController get addressController => _addressController;
  TextEditingController _phoneController = TextEditingController();
  TextEditingController get phoneController => _phoneController;

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

  void incrementItemQuantity(int index, BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(
      context,
      listen: false,
    );
    _cartItems[index].quantity++;
    if (productProvider.selectedProduct?.id == _cartItems[index].product.id) {
      productProvider.incrementProductQuantity();
    }
    notifyListeners();
  }

  void decrementItemQuantity(int index, BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(
      context,
      listen: false,
    );
    if (_cartItems[index].quantity > 1) {
      _cartItems[index].quantity--;
      if (productProvider.selectedProduct?.id == _cartItems[index].product.id) {
        productProvider.decrementProductQuantity();
      }

      notifyListeners();
    }
  }

  void removeCartItem(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
  }

  CartModel? getItemByProductId(String productId) {
    try {
      return _cartItems.firstWhere((item) => item.product.id == productId);
    } catch (e) {
      return null;
    }
  }

  Future<void> placeOrder() async{
    
  }
}
