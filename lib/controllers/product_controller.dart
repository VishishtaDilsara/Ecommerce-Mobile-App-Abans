import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/web.dart';
import 'package:my_abans/models/product_model.dart';

class ProductController {
  CollectionReference productCollection = FirebaseFirestore.instance.collection(
    'Products',
  );

  Future<bool> publishProduct(ProductModel product) async {
    try {
      await productCollection.doc(product.id).set(product.toJson());
      return true;
    } catch (e) {
      Logger().e(e);
      return false;
    }
  }
}
