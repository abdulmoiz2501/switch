import '../../domain/repository/order_repository.dart';
import '../../data/models/order_model.dart';
import '../source/order_data_source.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource remote;
  OrderRepositoryImpl(this.remote);

  @override
  Future<void> placeOrder(OrderModel order) async {
    await remote.placeOrder(order);
  }
}
