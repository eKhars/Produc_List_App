import '../models/product.dart';
import '../services/product_service.dart';

List<Product> productList = [
  Product(
    name: 'Cargando...',
    description: 'Cargando datos...',
    price: 0.0,
  ),
];

Future<void> loadProducts() async {
  try {
    final productService = ProductService();
    final apiProducts = await productService.getProducts();
    
    productList = apiProducts; 
  } catch (e) {
    print('Error al cargar productos: $e');
    
    productList = [
      Product(
        name: 'Laptop',
        description: 'Laptop potente con 16GB RAM',
        price: 15000.0,
      ),
      Product(
        name: 'Celular',
        description: 'Celular con buena cámara',
        price: 8500.0,
      ),
      Product(
        name: 'Audífonos',
        description: 'Audífonos con cancelación de ruido',
        price: 1200.0,
      ),
    ];
  }
}