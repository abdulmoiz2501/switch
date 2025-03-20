class ProductModel {
  final int id;
  final String title;
  final String imageUrl;
  final double price;
  final double rating;

  ProductModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.rating,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] ?? 0,
      title: map['title'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      price: (map['price'] as num).toDouble(),
      rating: (map['rating'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'imageUrl': imageUrl,
      'price': price,
      'rating': rating,
    };
  }
}
