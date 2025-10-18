import 'package:my_abans/models/product_model.dart';

class CartModel {
  ProductModel product;
  int quantity;

  CartModel({required this.product, this.quantity = 1});
}
