import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:products_explorer/data/repositories/product_repository.dart';
import 'package:products_explorer/data/services/api_service.dart';
import 'package:products_explorer/presentation/providers/mode_provider.dart';
import 'package:products_explorer/presentation/providers/products_provider.dart';
import 'package:products_explorer/presentation/screens/home/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ModeProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProductsProvider(ProductRepository(ApiService())),
        ),
      ],
      child: const MaterialApp(
        title: 'Products Explorer',
        home: HomeScreen(),
      ),
    );
  }
}