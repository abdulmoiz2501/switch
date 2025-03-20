import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> fetchProducts();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  @override
  Future<List<ProductModel>> fetchProducts() async {
    final jsonString = await rootBundle.loadString('assets/dummy/products.json');
    final List<dynamic> jsonList = json.decode(jsonString);


    return jsonList.map((map) => ProductModel.fromMap(map)).toList();
  }
}
