import 'dart:async';
import 'package:flutter/material.dart';
import '../../data/models/product_model.dart';
import '../../data/repositories/product_repository.dart';

class ProductsProvider extends ChangeNotifier {
  final ProductRepository repo;
  List<Product> products = [];
  List<Product> filteredProducts = [];
  bool isLoading = false;
  bool hasMore = true;
  String? errorMessage;
  String _searchQuery = '';
  int skip = 0;
  final _streamController = StreamController<List<Product>>.broadcast();

  ProductsProvider(this.repo) {
    filteredProducts = products;
  }

  Stream<List<Product>> get productsStream => _streamController.stream;

  String get searchQuery => _searchQuery;

  Future<void> fetchProducts({bool refresh = false}) async {
    if (isLoading || !hasMore) return;

    isLoading = true;
    notifyListeners();

    try {
      if (refresh) {
        skip = 0;
        products.clear();
        filteredProducts.clear();
        hasMore = true;
      }

      final newProducts = await repo.fetchProducts(skip);
      if (newProducts.isEmpty) {
        hasMore = false;
      } else {
        products.addAll(newProducts);
        skip += newProducts.length;
      }
      errorMessage = null;
      _filterProducts(); // Filter after fetching
      _streamController.add(filteredProducts); // Emit filtered products
    } catch (e) {
      errorMessage = 'Failed to load products: $e';
      _streamController.addError(errorMessage!);
    }

    isLoading = false;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    _filterProducts();
    _streamController.add(filteredProducts); // Update stream
    notifyListeners();
  }

  void _filterProducts() {
    if (_searchQuery.isEmpty) {
      filteredProducts = List.from(products);
    } else {
      filteredProducts = products
          .where((product) =>
          product.title.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    }
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }
}