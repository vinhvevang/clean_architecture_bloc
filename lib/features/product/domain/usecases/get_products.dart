import 'package:bloc_nearly_complete/features/product/domain/repository/product_repository.dart';

import '../entities/product.dart';


class GetProducts {
  final ProductRepository repository;

  GetProducts(this.repository);

  List<Product> call() {
    return repository.getProducts();
  }
}