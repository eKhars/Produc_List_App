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
  
  // Factory para la Fake Store API
  factory Product.fromApi(Map<String, dynamic> json) {
    final ratingData = json['rating'] as Map<String, dynamic>?;
    
    return Product(
      id: json['id'],
      name: json['title'], 
      description: json['description'],
      price: json['price'] is int 
          ? (json['price'] as int).toDouble() 
          : (json['price'] as num).toDouble(),
      category: json['category'],
      imageUrl: json['image'], 
      rating: ratingData != null 
          ? (ratingData['rate'] is int 
              ? (ratingData['rate'] as int).toDouble() 
              : (ratingData['rate'] as num).toDouble())
          : null,
      ratingCount: ratingData?['count'],
    );
  }
  
  factory Product.fromDummyJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['title'] ?? json['name'], 
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      category: json['category'],
      imageUrl: json['imageUrl'] ?? json['image'],
      rating: json['rating']?.toDouble(),
      ratingCount: json['ratingCount'],
    );
  }
}