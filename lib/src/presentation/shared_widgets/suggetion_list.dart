import 'package:flutter/material.dart';

class SuggestionList extends StatelessWidget {
  const SuggestionList({
    super.key,
    required this.suggestions,
    required this.onTap,
    this.maxVisibleItems = 3,
  });

  final List<String> suggestions;
  final ValueChanged<String> onTap;
  final int maxVisibleItems;

  @override
  Widget build(BuildContext context) {
    if (suggestions.isEmpty) return const SizedBox.shrink();

    // Estimate item height (ListTile default height is ~56)
    const itemHeight = 56.0;
    final visibleItemCount = suggestions.length < maxVisibleItems
        ? suggestions.length
        : maxVisibleItems;

    return Card(
      margin: const EdgeInsets.only(top: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 4,
      child: SizedBox(
        height: itemHeight * visibleItemCount,
        child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: suggestions.length,
          itemBuilder: (context, index) {
            final suggestion = suggestions[index];
            return ListTile(
              title: Text(suggestion),
              onTap: () => onTap(suggestion),
            );
          },
        ),
      ),
    );
  }
}
