import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:short_path/core/extensions/extensions.dart';
import 'package:short_path/core/styles/cached_network_image_widget.dart';
import 'package:short_path/src/presentation/mangers/profile/personal_profile_viewmodel.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../core/common/common_imports.dart';

class ProfileHeaderWidget extends StatelessWidget {
  const ProfileHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonalProfileCubit, PersonalProfileState>(
      builder: (context, state) {
        var viewmodel = context.read<PersonalProfileCubit>();
        bool isLoading = viewmodel.appUser == null;

        var profilePicture =
            'https://${viewmodel.profileEntity?.profilePicture}'; // Placeholder URL
        return Directionality(
          textDirection: TextDirection.ltr,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
            child: Skeletonizer(
              enabled: isLoading,
              child: Row(
                children: [
                  // Profile Picture
                  GestureDetector(
                    onTap: () {
                      // Open profile image update option
                    },
                    child: CircleAvatar(
                      radius: 40.0,
                      child: CachedNetworkImageWidget(
                          imageUrl: profilePicture,
                          width: double.infinity,
                          height: double.infinity),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  // Name and Title
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isLoading
                            ? context.localization.loading
                            : '${viewmodel.appUser?.firstName} ${viewmodel.appUser?.lastName}',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        isLoading
                            ? context.localization.loading
                            : viewmodel.profileEntity?.jobTitle ?? '',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
