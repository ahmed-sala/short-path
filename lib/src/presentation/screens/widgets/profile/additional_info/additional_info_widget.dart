import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:short_path/core/extensions/extensions.dart';
import 'package:short_path/src/presentation/screens/widgets/profile/profile_shared_widgets.dart';

import '../../../../../../core/common/common_imports.dart';
import '../../../../mangers/profile/personal_profile_viewmodel.dart';
import 'item_list_widget.dart';

class AdditionalInfoWidget extends StatelessWidget {
  const AdditionalInfoWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonalProfileCubit, PersonalProfileState>(
      builder: (context, state) {
        final cubit = context.read<PersonalProfileCubit>();
        final additionalInfo = cubit.additionalInfoEntity;

        if (state is AdditionalInfoLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              if (additionalInfo?.hobbiesAndInterests != null &&
                  additionalInfo!.hobbiesAndInterests!.isNotEmpty) ...[
                ReusableWidgets.sectionTitle(
                    context.localization.hobbiesInterests, Icons.favorite),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 4.0,
                  children: additionalInfo.hobbiesAndInterests!
                      .map((hobby) => ReusableWidgets.buildChip(hobby))
                      .toList(),
                ),
                const SizedBox(height: 16),
              ],
              if (additionalInfo?.publications != null &&
                  additionalInfo!.publications!.isNotEmpty) ...[
                ReusableWidgets.sectionTitle(
                    context.localization.publications, Icons.library_books),
                ItemList(items: additionalInfo.publications!),
                const SizedBox(height: 16),
              ],
              if (additionalInfo?.awardsAndHonors != null &&
                  additionalInfo!.awardsAndHonors!.isNotEmpty) ...[
                ReusableWidgets.sectionTitle(
                    context.localization.awardsAndHonors, Icons.emoji_events),
                ItemList(items: additionalInfo.publications!),
                const SizedBox(height: 16),
              ],
              if (additionalInfo?.volunteerWork != null &&
                  additionalInfo!.volunteerWork!.isNotEmpty) ...[
                ReusableWidgets.sectionTitle(context.localization.volunteerWork,
                    Icons.volunteer_activism),
                Column(
                  children: additionalInfo.volunteerWork!
                      .map((work) => ListTile(
                            leading: const Icon(Icons.handshake,
                                color: Colors.green),
                            title: Text(work.description),
                          ))
                      .toList(),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
