import 'package:get_it/get_it.dart';
import 'package:product_test/data/repositories/product_repository_impl.dart';
import 'package:product_test/domain/repositories/product_repository.dart';

class AppLocator {
  static void init() {
    final getIt = GetIt.I;

    getIt.registerSingleton<ProductRepository>(ProductRepositoryImpl());
  }

  static Future<void> dispose() async {
    return GetIt.I.reset();
  }
}
