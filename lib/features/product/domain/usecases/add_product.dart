import 'package:bloc_nearly_complete/features/product/domain/entities/product.dart';
import 'package:bloc_nearly_complete/features/product/domain/repository/product_repository.dart';
import 'package:flutter/material.dart';

class AddProduct {
   ProductRepository repository;
   AddProduct(this.repository);
   
  void call(Product product){
    repository.addProduct(product);
  }
  }
