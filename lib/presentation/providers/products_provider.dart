import 'package:flutter/material.dart';
import '../../data/models/product_model.dart';
import '../../data/repositories/product_repository.dart';

class ProductsProvider extends ChangeNotifier {
  final ProductRepository repo;
  List<Product> products = [];
  bool isLoading = false;
  bool hasMore = true;
  String? errorMessage;
  int _skip = 0;

  ProductsProvider(this.repo);

  Future<void> fetchProducts({bool refresh = false}) async {
    if (isLoading || !hasMore) return;

    isLoading = true;
    notifyListeners();

    try {
      if (refresh) {
        _skip = 0;
        products.clear();
        hasMore = true;
      }

      final newProducts = await repo.fetchProducts(_skip);
      if (newProducts.isEmpty) {
        hasMore = false;
      } else {
        products.addAll(newProducts);
        _skip += newProducts.length;
      }
      errorMessage = null;
    } catch (e) {
      errorMessage = 'Failed to load products: $e';
    }

    isLoading = false;
    notifyListeners();
  }
}