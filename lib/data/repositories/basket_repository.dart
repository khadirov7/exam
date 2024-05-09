import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/network_response.dart';
import '../models/product_model.dart';

class BasketRepository {
  Stream<List<ProductModel>> getBasketProduct() {
    return FirebaseFirestore.instance.collection('basket').snapshots().map(
        (querySnapshot) => querySnapshot.docs
            .map((doc) => ProductModel.fromJson(doc.data()))
            .toList());
  }

  Future<NetworkResponse> addProductBasket(ProductModel productModel) async {
    try {
      DocumentReference documentReference = await FirebaseFirestore.instance
          .collection('basket')
          .add(productModel.toJson());
      await FirebaseFirestore.instance
          .collection('basket')
          .doc(documentReference.id)
          .update({"id": documentReference.id});
      return NetworkResponse(data: "success");
    } on FirebaseException catch (error) {
      return NetworkResponse(errorText: error.toString());
    }
  }

  Future<NetworkResponse> updateProductBasket(ProductModel productModel) async {
    try {
      await FirebaseFirestore.instance
          .collection('basket')
          .doc(productModel.id)
          .update(productModel.toJsonForUpdate());
      return NetworkResponse(data: "success");
    } on FirebaseException catch (error) {
      return NetworkResponse(errorText: error.toString());
    }
  }

  Future<NetworkResponse> deleteProductBasket(String id) async {
    try {
      await FirebaseFirestore.instance.collection('basket').doc(id).delete();

      return NetworkResponse(data: "success");
    } on FirebaseException catch (error) {
      return NetworkResponse(errorText: error.toString());
    }
  }
}
