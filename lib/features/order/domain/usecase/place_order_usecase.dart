import '../repository/order_repository.dart';
import '../../data/models/order_model.dart';

class PlaceOrderUseCase {
  final OrderRepository orderRepository;

  PlaceOrderUseCase(this.orderRepository);

  Future<void> call(OrderModel order) {
    print("PlaceOrderUseCase: Received order: ${order.toMap()}");
    return orderRepository.placeOrder(order);
  }
}
