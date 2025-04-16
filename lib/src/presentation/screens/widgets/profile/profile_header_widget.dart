import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:short_path/core/extensions/extensions.dart';
import 'package:short_path/src/presentation/mangers/profile/personal_profile_viewmodel.dart';
import 'package:short_path/src/presentation/shared_widgets/image_widget.dart';
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
        print('user ${viewmodel.appUser}');
        var profilePicture =
            '${viewmodel.profileEntity?.profilePicture}'; // Placeholder URL
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
                  ImageWidget(
                    imageUrl: viewmodel.profileEntity?.profilePicture,
                    width: 120,
                    height: 120,
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
