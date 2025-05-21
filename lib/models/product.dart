class Product {
  final int? id;
  final String name;
  final String description;
  final double price;
  final String? category;
  final String? imageUrl;
  final double? rating;
  final int? ratingCount;

  Product({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    this.category,
    this.imageUrl,
    this.rating,
    this.ratingCount,
  });
}