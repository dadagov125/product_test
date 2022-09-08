part of 'product_bloc.dart';

class ProductState extends Equatable {
  ProductState({this.products = const [], this.totalCount = 0});

  final List<ProductModel> products;

  final int totalCount;

  bool get hasNext {
    return products.length < totalCount;
  }

  @override
  List<Object> get props => [products, totalCount];
}

class ProductLoadingState extends ProductState {
  ProductLoadingState({super.products, super.totalCount});

  ProductLoadingState.fromState(ProductState state)
      : super(products: state.products, totalCount: state.totalCount);
}
