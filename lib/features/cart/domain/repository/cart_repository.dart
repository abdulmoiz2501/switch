
import '../../data/models/cart_item_model.dart';

abstract class CartRepository {
  Future<void> addOrUpdateItem(CartItemModel item);
  Future<void> removeItem(int productId);
  Future<List<CartItemModel>> getAllItems();
  Future<void> clearCart();
}
