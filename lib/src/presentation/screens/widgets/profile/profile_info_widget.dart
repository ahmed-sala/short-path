import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:short_path/core/styles/colors/app_colore.dart';
import 'package:short_path/src/presentation/mangers/profile/personal_profile_viewmodel.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileInfoWidget extends StatelessWidget {
  const ProfileInfoWidget({Key? key}) : super(key: key);

  IconData _getIconForPortfolioLink(String link) {
    final lowerLink = link.toLowerCase();
    if (lowerLink.contains('github')) return FontAwesomeIcons.github;
    if (lowerLink.contains('behance')) return FontAwesomeIcons.behance;
    if (lowerLink.contains('dribbble')) return FontAwesomeIcons.dribbble;
    if (lowerLink.contains('linkedin')) return FontAwesomeIcons.linkedin;
    return Icons.link;
  }

  Widget _buildListTile(String label, String? value, {IconData? icon}) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primaryColor),
      title: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
      ),
      subtitle: Text(
        value?.isNotEmpty == true ? value! : 'Not provided',
        style: const TextStyle(fontSize: 14, color: Colors.black54),
      ),
      trailing:
          const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
    );
  }

  Widget _buildPortfolioIcons(List<String> links) {
    if (links.isEmpty) return const Text('Not provided');

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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonalProfileCubit, PersonalProfileState>(
      builder: (context, state) {
        final cubit = context.read<PersonalProfileCubit>();
        final profileEntity = cubit.profileEntity;

        if (profileEntity == null) {
          return const Center(child: Text('No profile data available.'));
        }

        if (state is ProfileLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          children: [
            _buildListTile('LinkedIn', profileEntity.linkedIn,
                icon: FontAwesomeIcons.linkedin),
            const Divider(),
            _buildListTile('Bio', profileEntity.bio, icon: Icons.info),
            const Divider(),
            ListTile(
              leading: Icon(Icons.web, color: AppColors.primaryColor),
              title: const Text(
                'Portfolio',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              subtitle: _buildPortfolioIcons(profileEntity.portfolioLinks),
            ),
          ],
        );
      },
    );
  }
}
