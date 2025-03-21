import '../../data/models/order_model.dart';

abstract class OrderRepository {
  Future<void> placeOrder(OrderModel order);
}
