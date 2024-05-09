import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nt_exam_4/blocs/basket/basket_event.dart';
import 'package:nt_exam_4/blocs/basket/basket_state.dart';
import 'package:nt_exam_4/data/repositories/basket_repository.dart';
import '../../data/models/network_response.dart';

class BasketBloc extends Bloc<BasketEvent, BasketState> {
  final BasketRepository basketRepository;

  BasketBloc({required this.basketRepository})
      : super(const BasketState(productNames: [])) {
    on<GetProductsBasketEvent>(GetProductsBasket);
    on<AddProductBasketEvent>(AddProductBasket);
    on<DeleteProductBasketEvent>(deleteBasketProduct);
    on<UpdateProductBasketEvent>(updateBasketProduct);
  }

  Future<void> updateBasketProduct(UpdateProductBasketEvent event, emit) async {
    emit(state.copyWith(status: BasketStatus.loading));
    NetworkResponse response =
        await basketRepository.updateProductBasket(event.product);
    if (response.errorText.isEmpty) {
      emit(state.copyWith(status: BasketStatus.success));
    } else {
      emit(state.copyWith(
          status: BasketStatus.failure, errorMessage: response.errorText));
    }
  }

  Future<void> GetProductsBasket(
      GetProductsBasketEvent event, Emitter<BasketState> emit) async {
    emit(state.copyWith(status: BasketStatus.loading));

    try {
      await for (final products in basketRepository.getBasketProduct()) {
        if (!emit.isDone) {
          emit(
              state.copyWith(status: BasketStatus.success, products: products));
        }
      }
    } catch (e) {
      if (!emit.isDone) {
        emit(state.copyWith(
            status: BasketStatus.failure, errorMessage: e.toString()));
      }
    }
  }

  Future<void> AddProductBasket(
      AddProductBasketEvent event, Emitter<BasketState> emit) async {
    try {
      await basketRepository.addProductBasket(event.product);

      if (!emit.isDone) {
        emit(state.copyWith(status: BasketStatus.productAdded));
      }
    } catch (e) {
      if (!emit.isDone) {
        emit(state.copyWith(
            status: BasketStatus.failure, errorMessage: e.toString()));
      }
    }
  }

  deleteBasketProduct(DeleteProductBasketEvent event, emit) async {
    emit(state.copyWith(status: BasketStatus.loading));
    NetworkResponse response =
        await basketRepository.deleteProductBasket(event.id);
    if (response.errorText.isEmpty) {
      emit(state.copyWith(status: BasketStatus.success));
    } else {
      emit(state.copyWith(
          status: BasketStatus.failure, errorMessage: response.errorText));
    }
  }
}
