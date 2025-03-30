import '../../../../../../core/common/common_imports.dart';
import '../profile_shared_widgets.dart';

class PersonalInfoTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData leadingIcon;

  const PersonalInfoTile({
    Key? key,
    required this.title,
    this.subtitle,
    required this.leadingIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ReusableWidgets.listTile(
      title: title,
      subtitle: subtitle,
      leadingIcon: leadingIcon,
    );
  }
}
