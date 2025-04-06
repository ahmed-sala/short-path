import '../../../../../core/common/common_imports.dart';
import '../../../../../core/styles/colors/app_colore.dart';

class ReusableWidgets {
  static Widget buildChip(String label, {Color? color}) {
    return Chip(
      label: Text(label),
      backgroundColor: (color ?? AppColors.primaryColor).withOpacity(0.1),
      labelStyle: TextStyle(color: color ?? AppColors.primaryColor),
    );
  }

  static Widget sectionTitle(String title, IconData? icon, {Color? iconColor}) {
    return Row(
      children: [
        if (icon != null)
          Icon(icon, color: iconColor ?? AppColors.primaryColor, size: 24),
        if (icon != null) const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  static Widget listTile({
    required String title,
    required String? subtitle,
    IconData? leadingIcon,
    Widget? trailing,
  }) {
    return ListTile(
      leading: leadingIcon != null
          ? Icon(leadingIcon, color: AppColors.primaryColor)
          : null,
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
      ),
      subtitle: Text(
        subtitle?.isNotEmpty == true ? subtitle! : 'Not provided',
        style: const TextStyle(fontSize: 14, color: Colors.black54),
      ),
      trailing: trailing,
    );
  }

  static Widget cardContainer({required Widget child}) {
    return Card(
      elevation: 4,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: child,
      ),
    );
  }
}
