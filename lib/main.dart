import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:products_explorer/data/repositories/product_repository.dart';
import 'package:products_explorer/data/services/api_service.dart';
import 'package:products_explorer/presentation/providers/mode_provider.dart';
import 'package:products_explorer/presentation/providers/products_provider.dart';
import 'package:products_explorer/presentation/providers/theme_provider.dart';
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
        ChangeNotifierProvider(create: (_) => ModeProvider()),
        ChangeNotifierProvider(create: (_) => ProductsProvider(ProductRepository(ApiService()))),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            title: 'Products Explorer',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              colorScheme: ColorScheme.fromSwatch(
                primarySwatch: Colors.blue,
                backgroundColor: Colors.white,
                brightness: Brightness.light, // Explicitly set to match light theme
              ),
              cardColor: Colors.grey[100],
              scaffoldBackgroundColor: Colors.white,
            ),
            darkTheme: ThemeData(
              primarySwatch: Colors.blue,
              colorScheme: ColorScheme.fromSwatch(
                primarySwatch: Colors.blue,
                backgroundColor: Colors.grey[900],
                brightness: Brightness.dark, // Explicitly set to match dark theme
              ),
              cardColor: Colors.grey[800],
              scaffoldBackgroundColor: Colors.grey[900],
            ),
            themeMode: themeProvider.themeMode,
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}