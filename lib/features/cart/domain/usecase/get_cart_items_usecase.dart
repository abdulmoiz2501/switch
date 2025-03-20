import '../../data/models/cart_item_model.dart';
import '../repository/cart_repository.dart';

class GetCartItemsUseCase {
  final CartRepository repository;

  GetCartItemsUseCase(this.repository);

  Future<List<CartItemModel>> call() async {
    return repository.getAllItems();
  }
}
