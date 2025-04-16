import '../../../../../core/common/common_imports.dart';

class StateItemWidget extends StatelessWidget {
  const StateItemWidget({
    super.key,
    required this.value,
    required this.label,
  });
  final String value;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value,
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
        SizedBox(height: 4.0),
        Text(label, style: TextStyle(fontSize: 14.0, color: Colors.grey[600])),
      ],
    );
  }
}
