import 'package:equatable/equatable.dart';

import '../../data/models/product_model.dart';

abstract class BasketEvent extends Equatable {}

class GetProductsBasketEvent extends BasketEvent {
  GetProductsBasketEvent();

  @override
  List<Object?> get props => [];
}

class AddProductBasketEvent extends BasketEvent {
  final ProductModel product;

  AddProductBasketEvent({required this.product});

  @override
  List<Object?> get props => [product];
}

class UpdateProductBasketEvent extends BasketEvent {
  final ProductModel product;

  UpdateProductBasketEvent({required this.product});

  @override
  List<Object?> get props => [product];
}

class DeleteProductBasketEvent extends BasketEvent {
  final String id;

  DeleteProductBasketEvent({required this.id});

  @override
  List<Object?> get props => [id];
}
