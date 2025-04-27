import '../../../../../../../core/common/common_imports.dart';

class EducationInfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final double iconSize;

  const EducationInfoRow({
    super.key,
    required this.icon,
    required this.text,
    this.iconSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: iconSize, color: Colors.grey),
        const SizedBox(width: 4),
        Expanded(child: Text(text, style: const TextStyle(fontSize: 14))),
      ],
    );
  }
}
