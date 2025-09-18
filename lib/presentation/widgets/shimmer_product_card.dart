import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerProductCard extends StatelessWidget {
  const ShimmerProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Shimmer.fromColors(
        baseColor: Theme.of(context).brightness == Brightness.light
            ? Colors.grey[300]!
            : Colors.grey[700]!,
        highlightColor: Theme.of(context).brightness == Brightness.light
            ? Colors.grey[100]!
            : Colors.grey[600]!,
        child: ListTile(
          leading: Container(
            width: 50,
            height: 50,
            color: Colors.white,
          ),
          title: Container(
            width: double.infinity,
            height: 16,
            color: Colors.white,
          ),
          subtitle: Container(
            width: double.infinity,
            height: 12,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}