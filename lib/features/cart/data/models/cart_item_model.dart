import 'package:hive/hive.dart';
import '../../../product/data/models/product_model.dart';

part 'cart_item_model.g.dart';

@HiveType(typeId: 1)
class CartItemModel extends HiveObject {
  @HiveField(0)
  final int productId;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String imageUrl;

  @HiveField(3)
  final double price;

  @HiveField(4)
  final double rating;

  @HiveField(5)
  final int quantity;

  CartItemModel({
    required this.productId,
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.rating,
    required this.quantity,
  });

  CartItemModel copyWith({
    int? productId,
    String? title,
    String? imageUrl,
    double? price,
    double? rating,
    int? quantity,
  }) {
    return CartItemModel(
      productId: productId ?? this.productId,
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      rating: rating ?? this.rating,
      quantity: quantity ?? this.quantity,
    );
  }
}
