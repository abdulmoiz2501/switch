import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/order_model.dart';

abstract class OrderRemoteDataSource {
  Future<void> placeOrder(OrderModel order);
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final FirebaseFirestore firestore;
  OrderRemoteDataSourceImpl(this.firestore);

  @override
  Future<void> placeOrder(OrderModel order) async {
    await firestore
        .collection('users')
        .doc(order.userId)
        .collection('orders')
        .doc(order.orderId)
        .set(order.toMap());
    print("OrderRemoteDataSourceImpl: Order saved to Firestore");
  }
}
