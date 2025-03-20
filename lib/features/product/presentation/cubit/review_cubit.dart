import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecase/add_review_usecase.dart';
import '../../data/models/review_model.dart';
import 'review_state.dart';

class ReviewCubit extends Cubit<ReviewState> {
  final AddReviewUseCase addReviewUseCase;

  ReviewCubit(this.addReviewUseCase) : super(ReviewInitial());

  Future<void> addReview({
    required String productId,
    required String userId,
    required double rating,
    required String reviewText,
  }) async {
    emit(ReviewLoading());
    try {
      final review = ReviewModel(
        userId: userId,
        rating: rating,
        reviewText: reviewText,
      );
      await addReviewUseCase(productId, review);
      emit(ReviewSuccess());
    } catch (e) {
      emit(ReviewError(e.toString()));
    }
  }
}
