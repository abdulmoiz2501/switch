import '../repository/cart_repository.dart';

class RemoveFromCartUseCase {
  final CartRepository repository;

  RemoveFromCartUseCase(this.repository);

  Future<void> call(int productId) async {
    await repository.removeItem(productId);
  }
}
