import '../../data/models/review_model.dart';

abstract class ReviewRepository {
  Future<void> addReview(String productId, ReviewModel review);
}
