import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:short_path/core/styles/colors/app_colore.dart';
import 'package:short_path/src/presentation/mangers/profile/personal_profile_viewmodel.dart';

class PersonalInfoWidget extends StatelessWidget {
  const PersonalInfoWidget({Key? key}) : super(key: key);

  Widget _buildListTile(String label, String? value, {IconData? icon}) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primaryColor),
      title: Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
      subtitle: Text(
        value ?? 'Not provided',
        style: const TextStyle(fontSize: 14, color: Colors.black54),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonalProfileCubit, PersonalProfileState>(
      builder: (context, state) {
        final viewmodel = context.read<PersonalProfileCubit>();
        final appUser = viewmodel.appUser;

        if (appUser == null) {
          return const Center(child: Text('No user data available.'));
        }

        return ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          children: [
            _buildListTile('Email', appUser.email, icon: Icons.email),
            const Divider(),
            _buildListTile('Mobile Number', appUser.mobileNumber,
                icon: Icons.phone),
            const Divider(),
            _buildListTile('Birth Date', appUser.birthDate, icon: Icons.cake),
            const Divider(),
            _buildListTile('Gender', appUser.gender == '0' ? 'Male' : 'Female',
                icon: Icons.person),
            const Divider(),
            _buildListTile('Address', appUser.address, icon: Icons.home),
          ],
        );
      },
    );
  }
}
