
import '../../domain/repository/cart_repository.dart';
import '../models/cart_item_model.dart';
import '../source/cart_local_data_source.dart';

class CartRepositoryImpl implements CartRepository {
  final CartLocalDataSource localDataSource;

  CartRepositoryImpl(this.localDataSource);

  @override
  Future<void> addOrUpdateItem(CartItemModel item) async {
    await localDataSource.addOrUpdateItem(item);
  }

  @override
  Future<void> removeItem(int productId) async {
    await localDataSource.removeItem(productId);
  }

  @override
  Future<List<CartItemModel>> getAllItems() async {
    return await localDataSource.getAllItems();
  }

  @override
  Future<void> clearCart() async {
    await localDataSource.clearCart();
  }
}
