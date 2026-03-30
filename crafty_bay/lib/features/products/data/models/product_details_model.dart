class ProductDetailsModel {
  final String id;
  final String title;
  final int currentPrice;
  final List<String> photos;
  final List<String> colors;
  final List<String> sizes;
  final List<String> tags;
  final int availableQuantity;
  final String description;

  ProductDetailsModel({
    required this.id,
    required this.title,
    required this.currentPrice,
    required this.photos,
    required this.colors,
    required this.sizes,
    required this.tags,
    required this.availableQuantity,
    required this.description,
  });

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailsModel(
      id: json['_id'],
      title: json['title'],
      currentPrice: json['current_price'],
      photos: List<String>.from(json['photos']),
      colors: List<String>.from(json['colors']),
      sizes: List<String>.from(json['sizes']),
      tags: List<String>.from(json['tags']),
      availableQuantity: json['quantity'],
      description: json['description'],
    );
  }
}
