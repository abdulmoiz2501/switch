class ReviewModel {
  final String userId;
  final double rating;
  final String reviewText;

  ReviewModel({
    required this.userId,
    required this.rating,
    required this.reviewText,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'rating': rating,
      'reviewText': reviewText,
    };
  }

  factory ReviewModel.fromMap(Map<String, dynamic> map) {
    return ReviewModel(
      userId: map['userId'] ?? '',
      rating: (map['rating'] as num).toDouble(),
      reviewText: map['reviewText'] ?? '',
    );
  }
}
