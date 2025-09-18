import 'package:flutter/material.dart';
import '../../data/models/product_model.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: product.thumbnail != null
            ? Image.network(
          product.thumbnail!,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
        )
            : const Icon(Icons.image_not_supported),
        title: Text(
          product.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '\$${(product.price * 88.16).toStringAsFixed(2)} | Rating: ${product.rating.toStringAsFixed(1)}', // dollar to rs
        ),
        onTap: () {
        },
      ),
    );
  }
}