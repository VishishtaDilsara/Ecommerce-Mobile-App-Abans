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

  Future<List<ProductModel>> fetchProducts() async {
    try {
      final data = await productCollection.get();
      final productData = data.docs;
      return productData
          .map(
            (doc) => ProductModel.fromJson(doc.data() as Map<String, dynamic>),
          )
          .toList();
    } catch (e) {
      Logger().e(e);
      return [];
    }
  }
}
