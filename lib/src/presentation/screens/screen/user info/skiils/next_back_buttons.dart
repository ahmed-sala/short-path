import 'package:flutter/material.dart';
import 'package:short_path/core/extensions/extensions.dart';
import 'dot_items.dart';

class NextBackButtons extends StatelessWidget {
  const NextBackButtons({
    super.key,
    required this.currentPage,
    required this.onNext,
    required this.onBack,
    required this.length,
  });

  final int currentPage;
  final VoidCallback onNext;
  final VoidCallback onBack;
  final int length;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            length,
            (index) => DotItems(isActive: index == currentPage),
          ),
        ),
        const SizedBox(height: 24.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (currentPage > 0)
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      side: BorderSide(color: Theme.of(context).primaryColor),
                    ),
                    onPressed: onBack,
                    child: Text(
                      context.localization.back,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
              if (currentPage > 0) const SizedBox(width: 16.0),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  onPressed: onNext,
                  child: Text(
                    currentPage < length - 1
                        ? context.localization.next
                        : context.localization.next,
                    style: const TextStyle(fontSize: 16.0, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
