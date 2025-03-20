import '../../data/models/cart_item_model.dart';
import '../repository/cart_repository.dart';

class AddToCartUseCase {
  final CartRepository repository;

  AddToCartUseCase(this.repository);

  Future<void> call(CartItemModel item) async {
    await repository.addOrUpdateItem(item);
  }
}
