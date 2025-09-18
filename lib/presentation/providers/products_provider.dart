import 'dart:async';
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
  final _streamController = StreamController<List<Product>>.broadcast();

  ProductsProvider(this.repo);

  Stream<List<Product>> get productsStream => _streamController.stream;

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
      _streamController.add(products); // Emit to stream
    } catch (e) {
      errorMessage = 'Failed to load products: $e';
      _streamController.addError(errorMessage!); // Emit error to stream
    }

    isLoading = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }
}