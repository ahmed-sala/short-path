import '../../../../../../../core/common/common_imports.dart';

class ItemList extends StatelessWidget {
  final List<String> items;

  const ItemList({Key? key, required this.items}) : super(key: key);

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
