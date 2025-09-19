import 'package:flutter_test/flutter_test.dart';
import 'package:products_explorer/data/models/product_model.dart';

void main() {
  group('Product Model', () {
    test('fromJson should map all fields correctly', () {
      final json = {
        "id": 1,
        "title": "Test Product",
        "description": "A sample description",
        "price": 199.99,
        "brand": "Test Brand",
        "category": "electronics",
        "rating": 4.5,
        "thumbnail": "https://example.com/image.jpg"
      };

      final product = Product.fromJson(json);

      expect(product.id, 1);
      expect(product.title, "Test Product");
      expect(product.description, "A sample description");
      expect(product.price, 199.99);
      expect(product.brand, "Test Brand");
      expect(product.category, "electronics");
      expect(product.rating, 4.5);
      expect(product.thumbnail, "https://example.com/image.jpg");
    });

    test('fromJson should handle missing optional fields', () {
      final json = {
        "id": 2,
        "title": "Another Product",
        "description": "Another description",
        "price": 50,
        "category": "clothing",
        "rating": 3.2,
      };

      final product = Product.fromJson(json);

      expect(product.id, 2);
      expect(product.title, "Another Product");
      expect(product.description, "Another description");
      expect(product.price, 50);
      expect(product.brand, null); // optional
      expect(product.category, "clothing");
      expect(product.rating, 3.2);
      expect(product.thumbnail, null); // optional
    });

    test('fromJson should apply default values when fields missing', () {
      final Map<String, dynamic> json = {}; // empty json

      final product = Product.fromJson(json);

      expect(product.id, 0);
      expect(product.title, "No Title");
      expect(product.description, "No Description");
      expect(product.price, 0.0);
      expect(product.brand, null);
      expect(product.category, "Unknown");
      expect(product.rating, 0.0);
      expect(product.thumbnail, null);
    });
  });
}
