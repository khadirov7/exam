import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product_model.dart';

class ProductsRepository {

  Stream<List<ProductModel>> getProducts() {
    return FirebaseFirestore.instance
        .collection('products')
        .snapshots()
        .map((querySnapshot) =>
        querySnapshot.docs
            .map((doc) => ProductModel.fromJson(doc.data()))
            .toList());
  }
}
