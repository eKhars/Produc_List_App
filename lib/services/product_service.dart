import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/api_product.dart';

class ProductService {
  static const String baseUrl = 'https://fakestoreapi.com';

  // Obtener todos los productos
  Future<List<ApiProduct>> getProducts() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/products'));
      
      if (response.statusCode == 200) {
        final List<dynamic> productsJson = json.decode(response.body);
        return productsJson.map((json) => ApiProduct.fromJson(json)).toList();
      } else {
        throw Exception('Error al cargar productos: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error en la conexión: $e');
    }
  }

  // Obtener un producto por ID
  Future<ApiProduct> getProduct(int id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/products/$id'));
      
      if (response.statusCode == 200) {
        return ApiProduct.fromJson(json.decode(response.body));
      } else {
        throw Exception('Error al cargar el producto: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error en la conexión: $e');
    }
  }

  // Obtener productos por categoría
  Future<List<ApiProduct>> getProductsByCategory(String category) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/products/category/$category')
      );
      
      if (response.statusCode == 200) {
        final List<dynamic> productsJson = json.decode(response.body);
        return productsJson.map((json) => ApiProduct.fromJson(json)).toList();
      } else {
        throw Exception('Error al cargar productos por categoría: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error en la conexión: $e');
    }
  }

  // Obtener todas las categorías
  Future<List<String>> getCategories() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/products/categories')
      );
      
      if (response.statusCode == 200) {
        final List<dynamic> categoriesJson = json.decode(response.body);
        return categoriesJson.map((category) => category.toString()).toList();
      } else {
        throw Exception('Error al cargar categorías: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error en la conexión: $e');
    }
  }
}