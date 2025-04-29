// import 'package:flutter/material.dart';
//
// class SuggestionList extends StatelessWidget {
//   const SuggestionList({
//     super.key,
//     required this.suggestions,
//     required this.onTap,
//   });
//   final List<String> suggestions;
//   final Function(int) onTap;
//
//   @override
//   Widget build(BuildContext context) {
//     const double listTileHeight =
//         56.0; // Adjust if your ListTile height is different
//     // Determine whether the list should be scrollable (i.e., more than 5 items)
//     final bool isScrollable = suggestions.length > 5;
//
//     return Container(
//       margin: const EdgeInsets.only(top: 8),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         border: Border.all(color: Colors.grey),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       // Use a ConstrainedBox to limit the maximum height when needed.
//       child: ConstrainedBox(
//         constraints: BoxConstraints(
//           maxHeight: isScrollable ? 5 * listTileHeight : double.infinity,
//         ),
//         child: ListView.builder(
//           // If not scrollable, let the ListView shrink wrap its content.
//           shrinkWrap: !isScrollable,
//           // Use default scroll physics when scrollable.
//           physics: isScrollable
//               ? const AlwaysScrollableScrollPhysics()
//               : const NeverScrollableScrollPhysics(),
//           itemCount: suggestions.length,
//           itemBuilder: (context, index) {
//             return ListTile(
//               title: Text(suggestions[index]),
//               onTap: () => onTap(index),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
