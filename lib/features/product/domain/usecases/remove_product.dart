import 'package:bloc_nearly_complete/features/product/domain/entities/product.dart';
import 'package:bloc_nearly_complete/features/product/domain/repository/product_repository.dart';

class RemoveProduct{
  ProductRepository repository;
  RemoveProduct(this.repository);

  void call(int id){
    repository.removeProduct(id);
  }
}