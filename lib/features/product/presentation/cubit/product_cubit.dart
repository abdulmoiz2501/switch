import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecase/fetch_products_usecase.dart';
import 'product_state.dart';
import '../../data/models/product_model.dart';

class ProductCubit extends Cubit<ProductState> {
  final FetchProductsUseCase fetchProductsUseCase;
  List<ProductModel> _allProducts = [];

  ProductCubit(this.fetchProductsUseCase) : super(ProductInitial());

  Future<void> fetchProducts() async {
    emit(ProductLoading());
    try {
      final products = await fetchProductsUseCase();
      _allProducts = products;
      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  void filterProducts(String query) {
    if (query.isEmpty) {
      emit(ProductLoaded(_allProducts));
    } else {
      final filtered = _allProducts.where((product) =>
          product.title.toLowerCase().contains(query.toLowerCase())
      ).toList();
      emit(ProductLoaded(filtered));
    }
  }
}
