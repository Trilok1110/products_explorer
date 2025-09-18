import '../models/product_model.dart';
import '../services/api_service.dart';

class ProductRepository {
  final ApiService api;

  ProductRepository(this.api);

  Future<List<Product>> fetchProducts(int skip, {int limit = 10}) async {
    try {
      final data = await api.get('/products', params: {
        'limit': limit,
        'skip': skip,
      });
      final productList = (data['products'] as List)
          .map((json) => Product.fromJson(json as Map<String, dynamic>))
          .toList();
      return productList;
    } catch (e) {
      throw Exception('Failed to fetch products: $e');
    }
  }
}