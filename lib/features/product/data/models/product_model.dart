class ProductModel {
  final int id;
  final String title;
  final String imageUrl;
  final double price;
  final double rating;
  final String description;
  final int soldCount;
  final int totalRatings;

  ProductModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.rating,
    required this.description,
    required this.soldCount,
    required this.totalRatings,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] ?? 0,
      title: map['title'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      price: (map['price'] as num).toDouble(),
      rating: (map['rating'] as num).toDouble(),
      description: map['description'] ?? '',
      soldCount: map['soldCount'] ?? 0,
      totalRatings: map['totalRatings'] ?? 0,
    );
  }
}
