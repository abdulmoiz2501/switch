import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecase/place_order_usecase.dart';
import '../../data/models/order_model.dart';
import 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final PlaceOrderUseCase placeOrderUseCase;

  OrderCubit({required this.placeOrderUseCase}) : super(OrderInitial());

  Future<void> placeOrder(OrderModel order) async {
    emit(OrderLoading());
    try {
      await placeOrderUseCase(order);
      print("OrderCubit: Order placed successfully");
      emit(OrderSuccess());
    } catch (e) {
      print("OrderCubit: Order error: $e");
      emit(OrderError(e.toString()));
    }
  }
}
