import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:short_path/core/extensions/extensions.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../core/common/common_imports.dart';
import '../../../../../../core/styles/colors/app_colore.dart';

class ProtofolioIconItem extends StatelessWidget {
  const ProtofolioIconItem({super.key, required this.links});
  final List<String> links;
  IconData _getIconForPortfolioLink(String link) {
    final lowerLink = link.toLowerCase();
    if (lowerLink.contains('github')) return FontAwesomeIcons.github;
    if (lowerLink.contains('behance')) return FontAwesomeIcons.behance;
    if (lowerLink.contains('dribbble')) return FontAwesomeIcons.dribbble;
    if (lowerLink.contains('linkedin')) return FontAwesomeIcons.linkedin;
    return Icons.link;
  }

  @override
  Widget build(BuildContext context) {
    if (links.isEmpty) return Text(context.localization.notProvided);
    return Wrap(
      spacing: 12.0,
      children: links.map((link) {
        return IconButton(
          icon: Icon(_getIconForPortfolioLink(link)),
          color: AppColors.primaryColor,
          onPressed: () async {
            final uri = Uri.parse(link);
            if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
              debugPrint('Could not launch $uri');
            }
          },
          tooltip: link,
        );
      }).toList(),
    );
  }
}
