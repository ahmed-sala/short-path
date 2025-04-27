import '../../../../../../../core/common/common_imports.dart';

class ItemList extends StatelessWidget {
  final List<String> items;

  const ItemList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items
          .map(
            (item) => ListTile(
              leading: const Icon(Icons.arrow_right, color: Colors.grey),
              title: Text(item),
            ),
          )
          .toList(),
    );
  }
}
