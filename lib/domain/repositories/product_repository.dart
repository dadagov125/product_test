import '../models/paginable.dart';
import '../models/product_model.dart';

abstract class ProductRepository {
  Future<ProductModel> createProduct();

  Future<Paginable<ProductModel>> getProducts({int take = 20, int skip = 0});

  Future<void> removeProduct(String id);
}
