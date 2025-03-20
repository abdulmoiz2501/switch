import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecase/fetch_products_usecase.dart';
import 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final FetchProductsUseCase fetchProductsUseCase;

  ProductCubit(this.fetchProductsUseCase) : super(ProductInitial());

  Future<void> fetchProducts() async {
    emit(ProductLoading());
    try {
      final products = await fetchProductsUseCase();
      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }
}
