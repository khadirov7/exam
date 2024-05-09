import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nt_exam_4/blocs/product/product_event.dart';
import 'package:nt_exam_4/blocs/product/product_state.dart';
import 'package:nt_exam_4/data/models/product_model.dart';
import '../../data/repositories/products_repositories.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductsRepository productsRepository;

  ProductBloc({required this.productsRepository})
      : super(const ProductState(productNames: [])) {
    on<GetProductsEvent>(GetProducts);
  }

  Future<void> GetProducts(
      GetProductsEvent event, Emitter<ProductState> emit) async {
    emit(state.copyWith(status: ProductsStatus.loading));
    try {
      await for (final products in productsRepository.getProducts()) {
        final filteredProducts = event.category == Category.Hammasi
            ? products
            : products.where((p) => p.category == event.category).toList();

        if (!emit.isDone) {
          emit(state.copyWith(
              status: ProductsStatus.success, products: filteredProducts));
        }
      }
    } catch (e) {
      if (!emit.isDone) {
        emit(state.copyWith(
            status: ProductsStatus.failure, errorMessage: e.toString()));
      }
    }
  }
}
