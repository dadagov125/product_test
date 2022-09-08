import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:product_test/domain/repositories/product_repository.dart';

import '../../../models/product_model.dart';

part 'product_event.dart';

part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductState()) {
    _registerHandlers();
  }

  final ProductRepository _productRepository = GetIt.I.get();

  _registerHandlers() {
    on<LoadProductsEvent>((event, emit) async {
      emit(ProductLoadingState.fromState(state));
      final paginable =
          await _productRepository.getProducts(skip: state.products.length);
      emit(ProductState(
          totalCount: paginable.totalCount,
          products: [...state.products, ...paginable.items]));
    });

    on<CreateProductsEvent>((event, emit) async {
      emit(ProductLoadingState.fromState(state));
      final product = await _productRepository.createProduct();
      emit(ProductState(
          totalCount: state.totalCount + 1,
          products: [product, ...state.products]));
    });

    on<RemoveProductsEvent>((event, emit) async {
      emit(ProductLoadingState.fromState(state));
      await _productRepository.removeProduct(event.id);
      final products = state.products.toList()
        ..removeWhere((element) => element.id == event.id);
      emit(ProductState(totalCount: state.totalCount - 1, products: products));
      if (products.length < 20) add(LoadProductsEvent());
    });
  }
}
