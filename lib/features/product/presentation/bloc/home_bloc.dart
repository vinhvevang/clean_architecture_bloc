import 'package:bloc/bloc.dart';
import 'package:bloc_nearly_complete/features/product/domain/entities/product.dart';
import 'package:bloc_nearly_complete/features/product/domain/usecases/add_product.dart';
import 'package:bloc_nearly_complete/features/product/domain/usecases/edit_product.dart';
import 'package:bloc_nearly_complete/features/product/domain/usecases/filtered_product.dart';
import 'package:bloc_nearly_complete/features/product/domain/usecases/find_product.dart';
import 'package:bloc_nearly_complete/features/product/domain/usecases/get_products.dart';
import 'package:bloc_nearly_complete/features/product/domain/usecases/remove_product.dart';
import 'package:bloc_nearly_complete/features/product/presentation/bloc/home_event.dart';
import 'package:bloc_nearly_complete/features/product/presentation/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AddProduct addProduct;
  final RemoveProduct removeProduct;
  final EditProduct editProduct;
  final FindProduct findProduct;
  final GetProducts getProducts;
  final FilterProduct filterProduct;

  // Lưu trạng thái bộ lọc hiện tại để kết hợp tìm kiếm + lọc giá
  String _keyword = '';
  int? _minPrice;
  int? _maxPrice;

  HomeBloc(
    this.addProduct,
    this.removeProduct,
    this.editProduct,
    this.findProduct,
    this.getProducts,
    this.filterProduct,
  ) : super(HomeState([], [])) {
    on<AddProductEvent>(_addProduct);
    on<RemoveProductEvent>(_removeProduct);
    on<EditProductEvent>(_editProduct);
    on<FindProductEvent>(_findProduct);
    on<FilterProductEvent>(_filterProduct);
  }

  // Áp dụng cả 2 bộ lọc (tên + giá) cùng lúc
  List<Product> _applyFilters() {
    return getProducts().where((p) {
      final matchesName =
          p.name.toLowerCase().contains(_keyword.toLowerCase());
      final matchesMin = _minPrice == null || p.price >= _minPrice!;
      final matchesMax = _maxPrice == null || p.price <= _maxPrice!;
      return matchesName && matchesMin && matchesMax;
    }).toList();
  }

  void _addProduct(AddProductEvent event, Emitter<HomeState> emit) {
    addProduct(event.product);
    final all = getProducts();
    emit(HomeState(all, _applyFilters()));
  }

  void _removeProduct(RemoveProductEvent event, Emitter<HomeState> emit) {
    removeProduct(event.id);
    final all = getProducts();
    emit(HomeState(all, _applyFilters()));
  }

  void _editProduct(EditProductEvent event, Emitter<HomeState> emit) {
    editProduct(event.product, event.id);
    final all = getProducts();
    emit(HomeState(all, _applyFilters()));
  }

  void _findProduct(FindProductEvent event, Emitter<HomeState> emit) {
    _keyword = event.keyword;
    emit(HomeState(state.products, _applyFilters()));
  }

  void _filterProduct(FilterProductEvent event, Emitter<HomeState> emit) {
    _minPrice = event.minPrice;
    _maxPrice = event.maxPrice;
    emit(HomeState(state.products, _applyFilters()));
  }
}
