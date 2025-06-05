import '../../../../../../core/common/common_imports.dart';
import '../../../../../../core/styles/colors/app_colore.dart';

class OutlineButtonWidget extends StatelessWidget {
  const OutlineButtonWidget(
      {super.key, required this.onTap, this.text, this.icon});
  final VoidCallback onTap;
  final String? text;
  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primaryColor,
        side: const BorderSide(color: AppColors.primaryColor, width: 2),
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: onTap,
      icon: Icon(icon ?? Icons.note_add, size: 24),
      label: Text(
        text ?? 'Cover Sheet',
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}
