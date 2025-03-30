import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:short_path/core/styles/colors/app_colore.dart';
import 'package:short_path/src/presentation/mangers/profile/personal_profile_viewmodel.dart';

class AdditionalInfoWidget extends StatelessWidget {
  const AdditionalInfoWidget({Key? key}) : super(key: key);

  Widget _buildChip(String label) {
    return Chip(
      label: Text(label),
      backgroundColor: AppColors.primaryColor.withOpacity(0.1),
      labelStyle: TextStyle(color: AppColors.primaryColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonalProfileCubit, PersonalProfileState>(
      builder: (context, state) {
        final cubit = context.read<PersonalProfileCubit>();
        final additionalInfo = cubit.additionalInfoEntity;

        // ** Show loading indicator until data is fetched **
        if (state is AdditionalInfoLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }

        // ** Ensure we only show "No data" when it's actually empty **
        final bool hasNoData = (additionalInfo?.hobbiesAndInterests == null ||
                additionalInfo!.hobbiesAndInterests!.isEmpty) &&
            (additionalInfo?.publications == null ||
                additionalInfo!.publications!.isEmpty) &&
            (additionalInfo?.awardsAndHonors == null ||
                additionalInfo!.awardsAndHonors!.isEmpty) &&
            (additionalInfo?.volunteerWork == null ||
                additionalInfo!.volunteerWork!.isEmpty);

        if (hasNoData) {
          return const Center(
              child: Text("No additional information available."));
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              if (additionalInfo?.hobbiesAndInterests != null &&
                  additionalInfo!.hobbiesAndInterests!.isNotEmpty) ...[
                _buildSectionTitle("Hobbies & Interests", Icons.favorite),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 4.0,
                  children: additionalInfo.hobbiesAndInterests!
                      .map((hobby) => _buildChip(hobby))
                      .toList(),
                ),
                const SizedBox(height: 16),
              ],
              if (additionalInfo?.publications != null &&
                  additionalInfo!.publications!.isNotEmpty) ...[
                _buildSectionTitle("Publications", Icons.library_books),
                _buildList(additionalInfo.publications!),
                const SizedBox(height: 16),
              ],
              if (additionalInfo?.awardsAndHonors != null &&
                  additionalInfo!.awardsAndHonors!.isNotEmpty) ...[
                _buildSectionTitle("Awards & Honors", Icons.emoji_events),
                _buildList(additionalInfo.awardsAndHonors!),
                const SizedBox(height: 16),
              ],
              if (additionalInfo?.volunteerWork != null &&
                  additionalInfo!.volunteerWork!.isNotEmpty) ...[
                _buildSectionTitle("Volunteer Work", Icons.volunteer_activism),
                Column(
                  children: additionalInfo.volunteerWork!.map((work) {
                    return ListTile(
                      leading: const Icon(Icons.handshake, color: Colors.green),
                      title: Text(work.description),
                    );
                  }).toList(),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primaryColor, size: 24),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildList(List<String> items) {
    return Column(
      children: items.map((item) {
        return ListTile(
          leading: const Icon(Icons.arrow_right, color: Colors.grey),
          title: Text(item),
        );
      }).toList(),
    );
  }
}
