import '../../../product/data/models/product_model.dart';

abstract class ProductRepository {
  Future<List<ProductModel>> getProducts();
}
