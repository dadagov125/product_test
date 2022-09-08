import 'package:product_test/domain/models/product_model.dart';
import 'package:product_test/domain/repositories/product_repository.dart';
import 'package:uuid/uuid.dart';
import 'package:username_gen/username_gen.dart';
import 'dart:math';

import '../../domain/models/paginable.dart';

final uuid = Uuid();
final rng = Random();

final List<String> imageUrls = [
  'https://m.media-amazon.com/images/I/81kx2IPueEL._SX522_.jpg',
  'https://st2.depositphotos.com/4431055/11854/i/600/depositphotos_118543552-stock-photo-coca-cola-can-isolated.jpg',
  'https://cdn-img.perekrestok.ru/i/400x400-fit/xdelivery/files/e1/14/8b69132df9f253a30351da38dafd.jpg'
];

List<ProductModel> generateProducts() {
  final minCount = 100000;
  final maxCount = 1000000;
  return List.generate(minCount + rng.nextInt(maxCount - minCount),
      (index) => generateProduct());
}

ProductModel generateProduct() {
  final product = ProductModel(
      id: uuid.v1(),
      name: UsernameGen().generate(),
      imageUrl: imageUrls[rng.nextInt(3)]);
  return product;
}

final List<ProductModel> _remoteProducts = generateProducts();

class ProductRepositoryImpl extends ProductRepository {
  @override
  Future<ProductModel> createProduct() async {
    final product = generateProduct();
    _remoteProducts.insert(0, product);
    return product;
  }

  @override
  Future<Paginable<ProductModel>> getProducts(
      {int take = 20, int skip = 0}) async {
    final items = _remoteProducts.skip(skip).take(take).toList();
    return Paginable(totalCount: _remoteProducts.length, items: items);
  }

  @override
  Future<void> removeProduct(String id) async {
    _remoteProducts.removeWhere((element) => element.id == id);
  }
}
