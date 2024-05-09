import 'package:equatable/equatable.dart';
import 'package:nt_exam_4/data/models/product_model.dart';

enum ProductsStatus { initial, loading, success, failure, productAdded }

class ProductState extends Equatable {
  final ProductsStatus status;
  final List<ProductModel> products;
  final List<String> productNames;
  final String errorMessage;

  const ProductState({
    required this.productNames,
    this.status = ProductsStatus.initial,
    this.products = const [],
    this.errorMessage = '',
  });

  ProductState copyWith({
    ProductsStatus? status,
    List<ProductModel>? products,
    String? errorMessage,
    List<String>? productNames,
  }) {
    return ProductState(
      productNames: productNames ?? this.productNames,
      status: status ?? this.status,
      products: products ?? this.products,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [status, products, errorMessage];
}
