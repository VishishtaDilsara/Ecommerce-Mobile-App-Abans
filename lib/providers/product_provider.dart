import 'package:flutter/material.dart';
import 'package:my_abans/controllers/product_controller.dart';
import 'package:my_abans/models/product_model.dart';

class ProductProvider extends ChangeNotifier {
  List<ProductModel> _products = [];
  List<ProductModel> get products => _products;

  bool _isProductFetched = false;
  bool get isProductFetched => _isProductFetched;

  Future<List<ProductModel>> fetchProducts() async {
    _products = await ProductController().fetchProducts();
    _isProductFetched = true;
    notifyListeners();

    return _products;
  }
}
