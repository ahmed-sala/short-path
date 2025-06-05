import '../../../../../../core/common/common_imports.dart';
import '../../../../../../core/styles/colors/app_colore.dart';

class IconButtonWidget extends StatelessWidget {
  const IconButtonWidget({
    super.key,
    required this.onTap,
    this.text,
  });
  final VoidCallback onTap;
  final String? text;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: onTap,
      icon: const Icon(Icons.description, size: 24, color: Colors.white),
      label: Text(
        text ?? 'Generate CV',
        style: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}
