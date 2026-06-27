import 'package:bloc_nearly_complete/features/product/domain/entities/product.dart';
import 'package:bloc_nearly_complete/features/product/domain/repository/product_repository.dart';

class FindProduct {
  final ProductRepository repository;

  FindProduct(this.repository);

  List<Product> call(String keyword) {
    return repository
        .getProducts()
        .where((p) =>
            p.name.toLowerCase().contains(keyword.toLowerCase()))
        .toList();
  }
}