import 'package:switch_test_task/features/product/data/models/product_model.dart';


import '../../domain/repository/product_repository.dart';
import '../source/product_data_source.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<ProductModel>> getProducts() async {
    return await remoteDataSource.fetchProducts();
  }
}
