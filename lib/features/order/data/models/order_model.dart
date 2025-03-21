class OrderModel {
  final String orderId;
  final String userId;
  final String userEmail;
  final String address;
  final List<Map<String,dynamic>> items;
  final double subtotal;
  final double shippingFee;
  final double discount;
  final double total;
  final DateTime timestamp;

  OrderModel({
    required this.orderId,
    required this.userId,
    required this.userEmail,
    required this.address,
    required this.items,
    required this.subtotal,
    required this.shippingFee,
    required this.discount,
    required this.total,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() => {
    'orderId': orderId,
    'userId': userId,
    'userEmail': userEmail,
    'address': address,
    'items': items,
    'subtotal': subtotal,
    'shippingFee': shippingFee,
    'discount': discount,
    'total': total,
    'timestamp': timestamp.toIso8601String(),
  };
}
