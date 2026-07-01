import 'package:bloc_nearly_complete/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:bloc_nearly_complete/features/auth/domain/usecases/login.dart';
import 'package:bloc_nearly_complete/features/auth/presentation/bloc/login_bloc.dart';
import 'package:bloc_nearly_complete/features/auth/presentation/pages/login_page.dart';
import 'package:bloc_nearly_complete/features/product/data/repositories/product_repository_impl.dart';
import 'package:bloc_nearly_complete/features/product/domain/usecases/add_product.dart';
import 'package:bloc_nearly_complete/features/product/domain/usecases/edit_product.dart';
import 'package:bloc_nearly_complete/features/product/domain/usecases/filtered_product.dart';
import 'package:bloc_nearly_complete/features/product/domain/usecases/find_product.dart';
import 'package:bloc_nearly_complete/features/product/domain/usecases/get_products.dart';
import 'package:bloc_nearly_complete/features/product/domain/usecases/remove_product.dart';
import 'package:bloc_nearly_complete/features/product/presentation/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  final authRepo = AuthRepositoryImpl();
  final productRepo = ProductRepositoryImpl();

  runApp(
    MultiBlocProvider(
      providers: [
        // LoginBloc – cấp top-level, reset qua LogoutEvent khi đăng xuất
        BlocProvider(
          create: (_) => LoginBloc(Login(authRepo)),
        ),
        // HomeBloc – cấp top-level để product data tồn tại suốt vòng đời app
        BlocProvider(
          create: (_) => HomeBloc(
            AddProduct(productRepo),
            RemoveProduct(productRepo),
            EditProduct(productRepo),
            FindProduct(productRepo),
            GetProducts(productRepo),
            FilterProduct(productRepo),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginPage(),
      ),
    ),
  );
}
