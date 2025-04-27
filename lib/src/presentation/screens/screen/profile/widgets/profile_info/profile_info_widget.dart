import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:short_path/core/extensions/extensions.dart';
import 'package:short_path/src/presentation/screens/screen/profile/widgets/profile_info/protofolio_icon_item.dart';

import '../../../../../../../core/common/common_imports.dart';
import '../../../../../../../core/styles/colors/app_colore.dart';
import '../../../../../mangers/profile/personal_profile_viewmodel.dart';
import '../profile_shared_widgets.dart';

class ProfileInfoWidget extends StatelessWidget {
  const ProfileInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonalProfileCubit, PersonalProfileState>(
      builder: (context, state) {
        final cubit = context.read<PersonalProfileCubit>();
        final profileEntity = cubit.profileEntity;

        if (profileEntity == null) {
          return Center(
              child: Text(context.localizations.noProfileDataAvailable));
        }
        if (state is ProfileLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          children: [
            ReusableWidgets.listTile(
              title: context.localization.linkedIn,
              subtitle: profileEntity.linkedIn,
              leadingIcon: FontAwesomeIcons.linkedin,
              context: context,
              trailing: const Icon(Icons.arrow_forward_ios,
                  size: 18, color: Colors.grey),
            ),
            const Divider(),
            ReusableWidgets.listTile(
              context: context,
              title: context.localization.bio,
              subtitle: profileEntity.bio,
              leadingIcon: Icons.info,
              trailing: const Icon(Icons.arrow_forward_ios,
                  size: 18, color: Colors.grey),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.web, color: AppColors.primaryColor),
              title: Text(
                context.localization.portfolio,
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              subtitle: ProtofolioIconItem(
                links: profileEntity.portfolioLinks,
              ),
              trailing: const Icon(Icons.arrow_forward_ios,
                  size: 18, color: Colors.grey),
            ),
          ],
        );
      },
    );
  }
}
