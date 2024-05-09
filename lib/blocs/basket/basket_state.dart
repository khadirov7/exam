import 'package:equatable/equatable.dart';
import '../../data/models/product_model.dart';

class BasketState extends Equatable {
  final BasketStatus status;
  final List<ProductModel> products;
  final List<String> productNames;
  final String errorMessage;

  const BasketState({
    required this.productNames,
    this.status = BasketStatus.initial,
    this.products = const [],
    this.errorMessage = '',
  });

  BasketState copyWith({
    BasketStatus? status,
    List<ProductModel>? products,
    String? errorMessage,
    List<String>? productNames,
  }) {
    return BasketState(
      productNames: productNames ?? this.productNames,
      status: status ?? this.status,
      products: products ?? this.products,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [status, products, errorMessage];
}

enum BasketStatus { initial, loading, success, failure, productAdded }
