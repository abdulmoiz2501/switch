import '../../domain/repository/review_repository.dart';
import '../models/review_model.dart';
import '../source/review_data_source.dart';

class ReviewRepositoryImpl implements ReviewRepository {
  final ReviewRemoteDataSource remoteDataSource;

  ReviewRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> addReview(String productId, ReviewModel review) {
    return remoteDataSource.addReview(productId: productId, review: review);
  }
}
