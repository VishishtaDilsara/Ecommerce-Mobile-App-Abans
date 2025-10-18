import 'package:flutter/material.dart';
import 'package:my_abans/controllers/product_controller.dart';
import 'package:my_abans/models/product_model.dart';

class ProductProvider extends ChangeNotifier {
  List<ProductModel> _products = [];
  List<ProductModel> get products => _products;

  ProductModel? _selectedProduct;
  ProductModel? get selectedProduct => _selectedProduct;

  bool _isProductFetched = false;
  bool get isProductFetched => _isProductFetched;

  int _selectedProductQuantity = 1;
  int get selectedProductQuantity => _selectedProductQuantity;

  Future<List<ProductModel>> fetchProducts() async {
    _products = await ProductController().fetchProducts();
    _isProductFetched = true;
    notifyListeners();

    return _products;
  }

  void setSelectedProduct(ProductModel product) {
    _selectedProduct = product;
    _selectedProductQuantity = 1;
    notifyListeners();
  }

  void incrementProductQuantity() {
    _selectedProductQuantity++;
    notifyListeners();
  }

  void decrementProductQuantity() {
    if (_selectedProductQuantity > 1) {
      _selectedProductQuantity--;
      notifyListeners();
    }
  }
}
