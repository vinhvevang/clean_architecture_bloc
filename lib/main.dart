import 'package:bloc_nearly_complete/features/product/data/repositories/product_repository_impl.dart';
import 'package:bloc_nearly_complete/features/product/domain/usecases/add_product.dart';
import 'package:bloc_nearly_complete/features/product/domain/usecases/edit_product.dart';
import 'package:bloc_nearly_complete/features/product/domain/usecases/filtered_product.dart';
import 'package:bloc_nearly_complete/features/product/domain/usecases/find_product.dart';
import 'package:bloc_nearly_complete/features/product/domain/usecases/get_products.dart';
import 'package:bloc_nearly_complete/features/product/domain/usecases/remove_product.dart';
import 'package:bloc_nearly_complete/features/product/presentation/bloc/home_bloc.dart';
import 'package:bloc_nearly_complete/features/product/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  final repository = ProductRepositoryImpl();
  final addProductUsecase = AddProduct(repository);
  final RemoveProductUsecase = RemoveProduct(repository);
  final editProductUsecase = EditProduct(repository);
  final findProductUseCase = FindProduct(repository);
  final getProductUseCase = GetProducts(repository);
  final filterProductUseCase = FilterProduct(repository); // THÊM
  runApp(
    BlocProvider(
      create:
          (_) => HomeBloc(
            addProductUsecase,
            RemoveProductUsecase,
            editProductUsecase,
            findProductUseCase,
            getProductUseCase,
            filterProductUseCase, // THÊM
          ),
      child: MaterialApp(home: HomePage(),debugShowCheckedModeBanner:false,),
    ),
  );
}
