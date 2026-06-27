import 'package:bloc_nearly_complete/features/product/domain/entities/product.dart';

abstract class HomeEvent {}

class AddProductEvent extends HomeEvent {
  Product product;
  AddProductEvent(this.product);
}

class EditProductEvent extends HomeEvent {
  Product product;
  int id;
  EditProductEvent(this.product, this.id);
}

class RemoveProductEvent extends HomeEvent {
  int id;
  RemoveProductEvent(this.id);
}

// FIX: đổi field 'name' → 'keyword' để khớp với home_bloc.dart (event.keyword)
class FindProductEvent extends HomeEvent {
  String keyword;
  FindProductEvent(this.keyword);
}

// THÊM: lọc theo khoảng giá (minPrice/maxPrice nullable = bỏ lọc)
class FilterProductEvent extends HomeEvent {
  final int? minPrice;
  final int? maxPrice;
  FilterProductEvent({this.minPrice, this.maxPrice});
}
