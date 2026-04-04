import 'package:crafty_bay/features/products/data/models/product_model.dart';

class CartItemModel {
  final String id;
  final ProductModel productModel;
  int quantity;
  final String? color;
  final String? size;

  CartItemModel({
    required this.id,
    required this.productModel,
    required this.quantity,
    required this.color,
    required this.size,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['_id'],
      productModel: ProductModel.fromJson(json['product']),
      quantity: json['quantity'],
      color: json['color'],
      size: json['size'],
    );
  }
}
