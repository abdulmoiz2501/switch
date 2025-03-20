import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/review_model.dart';

abstract class ReviewRemoteDataSource {
  Future<void> addReview({
    required String productId,
    required ReviewModel review,
  });
}

class ReviewRemoteDataSourceImpl implements ReviewRemoteDataSource {
  final FirebaseFirestore firestore;

  ReviewRemoteDataSourceImpl(this.firestore);

  @override
  Future<void> addReview({
    required String productId,
    required ReviewModel review,
  }) async {
    // firebase heirarcy: reviews -> productId -> doc(userId) -> review data
    await firestore
        .collection('reviews')
        .doc(productId)
        .collection('userReviews')
        .doc(review.userId)
        .set(review.toMap());
  }
}
