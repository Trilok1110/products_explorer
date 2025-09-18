import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/products_provider.dart';
import '../../widgets/product_card.dart';

class FutureListView extends StatefulWidget {
  const FutureListView({super.key});

  @override
  State<FutureListView> createState() => _FutureListViewState();
}

class _FutureListViewState extends State<FutureListView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<ProductsProvider>(context, listen: false);
      provider.fetchProducts();
    });
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        Provider.of<ProductsProvider>(context, listen: false).fetchProducts();
      }
    });
  }
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductsProvider>(
      builder: (context, provider, _) {
        if (provider.isLoading && provider.filteredProducts.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        if (provider.errorMessage != null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(provider.errorMessage!),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => provider.fetchProducts(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }
        if (provider.filteredProducts.isEmpty) {
          return const Center(child: Text('No products found'));
        }
        return RefreshIndicator(
          onRefresh: () => provider.fetchProducts(refresh: true),
          child: ListView.builder(
            controller: _scrollController,
            itemCount: provider.filteredProducts.length + (provider.hasMore ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == provider.filteredProducts.length && provider.hasMore) {
                return const Center(child: CircularProgressIndicator());
              }
              return ProductCard(product: provider.filteredProducts[index]);
            },
          ),
        );
      },
    );
  }
}