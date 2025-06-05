import '../../../core/common/common_imports.dart';
import '../screens/screen/career/widgets/icon_button_widget.dart';
import '../screens/screen/career/widgets/outline_button_widget.dart';

class ButtonsSectionWidget extends StatelessWidget {
  const ButtonsSectionWidget(
      {super.key,
      required this.onGenerateCoverSheetTap,
      required this.onGenerateCvTap,
      this.boldButtonText,
      this.outlineButtonText,
      this.outlineButtonIcon});
  final VoidCallback onGenerateCoverSheetTap;
  final VoidCallback onGenerateCvTap;
  final String? boldButtonText;
  final String? outlineButtonText;
  final IconData? outlineButtonIcon;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: IconButtonWidget(
            onTap: onGenerateCvTap,
            text: boldButtonText,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: OutlineButtonWidget(
            onTap: onGenerateCoverSheetTap,
            text: outlineButtonText,
            icon: outlineButtonIcon,
          ),
        ),
      ],
    );
  }
}
