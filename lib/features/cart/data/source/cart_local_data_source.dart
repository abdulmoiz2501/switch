import 'package:hive/hive.dart';
import '../models/cart_item_model.dart';

abstract class CartLocalDataSource {
  Future<void> addOrUpdateItem(CartItemModel item);
  Future<void> removeItem(int productId);
  Future<List<CartItemModel>> getAllItems();
  Future<void> clearCart();
}

class CartLocalDataSourceImpl implements CartLocalDataSource {
  static const String cartBoxName = 'cart_box';

  @override
  Future<void> addOrUpdateItem(CartItemModel item) async {
    print("The item being added to hive is: $item");
    final box = await Hive.openBox<CartItemModel>(cartBoxName);
    await box.put(item.productId, item);
  }

  @override
  Future<void> removeItem(int productId) async {
    print("The item being removed from hive is: $productId");
    final box = await Hive.openBox<CartItemModel>(cartBoxName);
    await box.delete(productId);
  }

  @override
  Future<List<CartItemModel>> getAllItems() async {
    final box = await Hive.openBox<CartItemModel>(cartBoxName);
    return box.values.toList();
  }

  @override
  Future<void> clearCart() async {
    final box = await Hive.openBox<CartItemModel>(cartBoxName);
    await box.clear();
  }
}
