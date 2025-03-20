import '../../data/models/review_model.dart';
import '../repository/review_repository.dart';

class AddReviewUseCase {
  final ReviewRepository repository;

  AddReviewUseCase(this.repository);

  Future<void> call(String productId, ReviewModel review) {
    return repository.addReview(productId, review);
  }
}
