import '../../data/models/product_model.dart';
import '../repository/product_repository.dart';

class FetchProductsUseCase {
  final ProductRepository repository;

  FetchProductsUseCase(this.repository);

  Future<List<ProductModel>> call() async {
    return repository.getProducts();
  }
}
