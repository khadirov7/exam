import 'package:equatable/equatable.dart';
import 'package:nt_exam_4/data/models/product_model.dart';

abstract class ProductEvent extends Equatable {}

class GetProductsEvent extends ProductEvent {
  final Category category;
  final String productName;

  GetProductsEvent({required this.category, required this.productName});

  @override
  List<Object?> get props => [category, productName];
}

class AddProductEvent extends ProductEvent {
  final ProductModel product;

  AddProductEvent({required this.product});

  @override
  List<Object?> get props => [product];
}
