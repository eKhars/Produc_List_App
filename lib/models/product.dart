class Product {
  final int? id;
  final String name;
  final String description;
  final double price;
  final String? category;
  final String? imageUrl;
  final double? rating;
  final int? ratingCount;
  
  String get title => name;

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
  
  factory Product.fromDummyJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['title'],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
    );
  }
}