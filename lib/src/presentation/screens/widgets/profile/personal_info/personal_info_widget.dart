import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:short_path/core/extensions/extensions.dart';
import 'package:short_path/src/presentation/screens/widgets/profile/personal_info/personal_info_tile.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../../core/common/common_imports.dart';
import '../../../../mangers/profile/personal_profile_viewmodel.dart';

class PersonalInfoWidget extends StatelessWidget {
  const PersonalInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonalProfileCubit, PersonalProfileState>(
      builder: (context, state) {
        final cubit = context.read<PersonalProfileCubit>();
        final appUser = cubit.appUser;
        bool isLoading = appUser == null;

        return Skeletonizer(
          enabled: isLoading,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            children: [
              PersonalInfoTile(
                title: context.localization.email,
                subtitle: appUser?.email,
                leadingIcon: Icons.email,
              ),
              const Divider(),
              PersonalInfoTile(
                title: context.localization.phoneNumber,
                subtitle: appUser?.mobileNumber,
                leadingIcon: Icons.phone,
              ),
              const Divider(),
              PersonalInfoTile(
                title: context.localization.birthDate,
                subtitle: appUser?.birthDate,
                leadingIcon: Icons.cake,
              ),
              const Divider(),
              PersonalInfoTile(
                title: context.localization.gender,
                subtitle: appUser?.gender == '0'
                    ? context.localization.male
                    : context.localization.female,
                leadingIcon: Icons.person,
              ),
              const Divider(),
              PersonalInfoTile(
                title: context.localization.address,
                subtitle: appUser?.address,
                leadingIcon: Icons.home,
              ),
            ],
          ),
        );
      },
    );
  }
}
