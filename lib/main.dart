import 'package:flutter/material.dart';
import 'data/products.dart';
import 'screens/product_detail_screen.dart';
import 'screens/cart_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fake Store API',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ProductListScreen(),
    );
  }
}

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    await loadProducts();
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _refreshProducts() async {
    setState(() {
      _isLoading = true;
    });
    await _loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fake Store API'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => CartScreen()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _refreshProducts,
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _refreshProducts,
              child: ListView.builder(
                itemCount: productList.length,
                itemBuilder: (context, index) {
                  final product = productList[index];
                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          // Imagen del producto
                          if (product.imageUrl != null)
                            Container(
                              width: 80,
                              height: 80,
                              child: Image.network(
                                product.imageUrl!,
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) {
                                  return Icon(Icons.image_not_supported, size: 50);
                                },
                              ),
                            )
                          else
                            Container(
                              width: 80,
                              height: 80,
                              color: Colors.grey[200],
                              child: Icon(Icons.image, color: Colors.grey),
                            ),
                          SizedBox(width: 12),
                          // Información del producto
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.name,
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 4),
                                if (product.category != null)
                                  Text(
                                    product.category!,
                                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                                  ),
                                SizedBox(height: 4),
                                Text(
                                  '\$${product.price.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green[700],
                                    fontSize: 15,
                                  ),
                                ),
                                if (product.rating != null)
                                  Row(
                                    children: [
                                      Icon(Icons.star, color: Colors.amber, size: 16),
                                      SizedBox(width: 4),
                                      Text(
                                        '${product.rating!.toStringAsFixed(1)} (${product.ratingCount})',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                          // Flecha para navegar al detalle
                          IconButton(
                            icon: Icon(Icons.arrow_forward_ios),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ProductDetailScreen(product: product),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}