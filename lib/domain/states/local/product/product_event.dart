part of 'product_bloc.dart';

class ProductEvent {
  const ProductEvent();
}

class LoadProductsEvent extends ProductEvent {}

class CreateProductsEvent extends ProductEvent {}

class RemoveProductsEvent extends ProductEvent {
  RemoveProductsEvent(this.id);

  final String id;
}
