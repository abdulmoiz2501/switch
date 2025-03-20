import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../product/data/models/product_model.dart';
import '../../data/models/cart_item_model.dart';
import '../../domain/usecase/add_to_cart_usecase.dart';
import '../../domain/usecase/get_cart_items_usecase.dart';
import '../../domain/usecase/remove_from_cart_usecase.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final AddToCartUseCase addToCartUseCase;
  final RemoveFromCartUseCase removeFromCartUseCase;
  final GetCartItemsUseCase getCartItemsUseCase;

  CartCubit({
    required this.addToCartUseCase,
    required this.removeFromCartUseCase,
    required this.getCartItemsUseCase,
  }) : super(CartInitial());

  Future<void> loadCartItems() async {
    emit(CartLoading());
    try {
      final items = await getCartItemsUseCase();
      emit(_buildCartLoaded(items));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> addOrUpdateProduct(ProductModel product) async {
    try {
      final cartItem = CartItemModel(
        productId: product.id,
        title: product.title,
        imageUrl: product.imageUrl,
        price: product.price,
        rating: product.rating,
        quantity: 1,
      );
      await addToCartUseCase(cartItem);
      loadCartItems();
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> removeProduct(int productId) async {
    try {
      await removeFromCartUseCase(productId);
      loadCartItems();
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  bool isProductInCart(ProductModel product) {
    if (state is CartLoaded) {
      final loaded = state as CartLoaded;
      return loaded.items.any((i) => i.productId == product.id);
    }
    return false;
  }

  CartLoaded _buildCartLoaded(List<CartItemModel> items) {
    final subtotal = items.fold(0.0, (sum, item) => sum + item.price * item.quantity);
    final shippingFee = subtotal * 0.1;
    final discountFraction = 0.2;
    final total = (subtotal + shippingFee) - (subtotal * discountFraction);

    return CartLoaded(
      items: items,
      subtotal: subtotal,
      shippingFee: shippingFee,
      discount: discountFraction * 100,
      total: total,
    );
  }
}
