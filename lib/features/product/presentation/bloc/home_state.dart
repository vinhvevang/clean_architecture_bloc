import 'package:bloc_nearly_complete/features/product/domain/entities/product.dart';

class HomeState {
  final List<Product> products;
  final List<Product> filteredProducts;

  HomeState(this.products, this.filteredProducts);
}