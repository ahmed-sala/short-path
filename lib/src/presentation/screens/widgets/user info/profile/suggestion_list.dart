import 'package:flutter/material.dart';

class SuggestionList extends StatelessWidget {
  const SuggestionList(
      {super.key, required this.suggestions, required this.onTap});
  final List<String> suggestions;
  final Function(int) onTap;
  @override
  Widget build(BuildContext context) {
    print(
        "Building SuggestionList with ${suggestions.length} items"); // Debug print

    return Container(
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(suggestions[index]),
            onTap: () => onTap(index),
          );
        },
      ),
    );
  }
}
