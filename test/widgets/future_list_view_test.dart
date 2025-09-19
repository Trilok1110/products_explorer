import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:products_explorer/data/models/product_model.dart';
import 'package:products_explorer/data/repositories/product_repository.dart';
import 'package:products_explorer/data/services/api_service.dart';
import 'package:products_explorer/presentation/providers/products_provider.dart';
import 'package:products_explorer/presentation/screens/home/future_list_view.dart';

/// Fake repository for testing
class FakeProductRepository extends ProductRepository {
  FakeProductRepository() : super(_FakeApiService());

  @override
  Future<List<Product>> fetchProducts(int skip, {int limit = 10}) async {
    return []; // no real API call
  }
}

/// Dummy ApiService
class _FakeApiService implements ApiService {
  @override
  Future<Map<String, dynamic>> get(String endpoint,
      {Map<String, dynamic>? params}) async {
    return {};
  }

  @override
  Future<Map<String, dynamic>> post(String endpoint,
      {Map<String, dynamic>? body}) async {
    return {};
  }
}

void main() {
  group('FutureListView Widget Tests', () {
    testWidgets('renders list of products', (WidgetTester tester) async {
      final provider = ProductsProvider(FakeProductRepository());

      provider.products = [
        Product(
          id: 1,
          title: 'Test Product 1',
          description: 'Description 1',
          price: 99.99,
          brand: 'Brand A',
          category: 'electronics',
          rating: 4.5,
          thumbnail: null,
        ),
        Product(
          id: 2,
          title: 'Test Product 2',
          description: 'Description 2',
          price: 49.99,
          brand: 'Brand B',
          category: 'clothing',
          rating: 3.8,
          thumbnail: null,
        ),
      ];
      provider.filteredProducts = List.from(provider.products);

      await tester.pumpWidget(
        ChangeNotifierProvider<ProductsProvider>.value(
          value: provider,
          child: const MaterialApp(home: FutureListView()),
        ),
      );

      expect(find.text('Test Product 1'), findsOneWidget);
      expect(find.text('Test Product 2'), findsOneWidget);
    });

    testWidgets('shows "No products found" when list is empty',
            (WidgetTester tester) async {
          final provider = ProductsProvider(FakeProductRepository());
          provider.products = [];
          provider.filteredProducts = [];

          await tester.pumpWidget(
            ChangeNotifierProvider<ProductsProvider>.value(
              value: provider,
              child: const MaterialApp(home: FutureListView()),
            ),
          );

          expect(find.text('No products found'), findsOneWidget);
        });
  });
}
