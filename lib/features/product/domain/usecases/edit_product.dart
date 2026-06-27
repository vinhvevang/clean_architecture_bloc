import 'package:bloc_nearly_complete/features/product/domain/entities/product.dart';
import 'package:bloc_nearly_complete/features/product/domain/repository/product_repository.dart';

class EditProduct {
ProductRepository repository;

EditProduct(this.repository);

void call(Product product,int id){
  repository.editProduct(product,id);
}
}