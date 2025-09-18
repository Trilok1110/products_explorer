import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/debouncer.dart';
import '../../providers/mode_provider.dart';
import '../../providers/products_provider.dart';
import '../about/about_screen.dart';
import 'future_list_view.dart';
import 'stream_list_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  final Debouncer _debouncer = Debouncer(delay: const Duration(milliseconds: 500));

  @override
  void dispose() {
    _searchController.dispose();
    _debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: .05),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search products...',
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                  icon: const Icon(Icons.clear, color: Colors.grey),
                  onPressed: () {
                    _searchController.clear();
                    _debouncer.run(() {
                      Provider.of<ProductsProvider>(context, listen: false)
                          .setSearchQuery('');
                    });
                  },
                )
                    : null,
              ),
              onChanged: (value) {
                _debouncer.run(() {
                  Provider.of<ProductsProvider>(context, listen: false)
                      .setSearchQuery(value);
                });
              },
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutScreen()),
              );
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Consumer<ModeProvider>(
            builder: (context, modeProvider, _) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildChoiceChip(
                        context,
                        label: 'Future',
                        selected: modeProvider.mode == Mode.future,
                        onSelected: (selected) {
                          if (selected) modeProvider.setMode(Mode.future);
                        },
                      ),
                      _buildChoiceChip(
                        context,
                        label: 'Stream',
                        selected: modeProvider.mode == Mode.stream,
                        onSelected: (selected) {
                          if (selected) modeProvider.setMode(Mode.stream);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
      body: Consumer<ModeProvider>(
        builder: (context, modeProvider, _) {
          return modeProvider.mode == Mode.future
              ? const FutureListView()
              : const StreamListView();
        },
      ),
    );
  }

  Widget _buildChoiceChip(
      BuildContext context, {
        required String label,
        required bool selected,
        required ValueChanged<bool> onSelected,
      }) {
    return ChoiceChip(
      showCheckmark: false,
      label: Text(label),
      selected: selected,
      onSelected: onSelected,
      selectedColor: Theme.of(context).colorScheme.secondary,
      backgroundColor: Colors.grey[300],
      labelStyle: TextStyle(
        color: selected ? Colors.white : Colors.black87,
        fontWeight: FontWeight.bold,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    );
  }
}