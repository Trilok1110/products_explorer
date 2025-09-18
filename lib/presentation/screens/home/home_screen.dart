import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/mode_provider.dart';
import 'future_list_view.dart';
import 'stream_list_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products Explorer'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Consumer<ModeProvider>(
            builder: (context, modeProvider, _) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildChoiceChip(
                      context,
                      label: 'Future',
                      selected: modeProvider.mode == Mode.future,
                      onSelected: (selected) {
                        if (selected) modeProvider.setMode(Mode.future);
                      },
                    ),
                    const SizedBox(width: 12),
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