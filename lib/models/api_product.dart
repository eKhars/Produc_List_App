import 'product.dart';

class ApiProduct {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final Rating rating;

  ApiProduct({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  // Convertir de JSON a objeto ApiProduct
  factory ApiProduct.fromJson(Map<String, dynamic> json) {
    return ApiProduct(
      id: json['id'],
      title: json['title'],
      price: json['price'] is int 
          ? (json['price'] as int).toDouble() 
          : (json['price'] as num).toDouble(),
      description: json['description'],
      category: json['category'],
      image: json['image'],
      rating: Rating.fromJson(json['rating']),
    );
  }

  // Convertir al modelo Product existente
  Product toProduct() {
    return Product(
      id: id,
      name: title,
      description: description,
      price: price,
      category: category,
      imageUrl: image,
      rating: rating.rate,
      ratingCount: rating.count,
    );
  }
}

class Rating {
  final double rate;
  final int count;

  Rating({
    required this.rate,
    required this.count,
  });

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      rate: json['rate'] is int 
          ? (json['rate'] as int).toDouble() 
          : (json['rate'] as num).toDouble(),
      count: json['count'],
    );
  }
}