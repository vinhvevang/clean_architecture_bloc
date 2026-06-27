import 'package:bloc_nearly_complete/features/product/domain/entities/product.dart';

class ProductModels {
  String name;
  int price;
  int quan;
  ProductModels(this.name, this.price, this.quan);

  // Product toEntity() {
  //   return Product(this.name, this.price, this.quan);
  // }
}
