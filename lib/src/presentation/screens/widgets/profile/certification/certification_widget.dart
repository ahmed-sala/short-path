import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:short_path/core/extensions/extensions.dart';

import '../../../../../../core/common/common_imports.dart';
import '../../../../mangers/profile/personal_profile_viewmodel.dart';
import 'certification_card.dart';

class CertificationsWidget extends StatelessWidget {
  const CertificationsWidget({Key? key}) : super(key: key);

  String _formatDate(DateTime? date) {
    return date != null ? DateFormat.yMMM().format(date) : "N/A";
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonalProfileCubit, PersonalProfileState>(
      builder: (context, state) {
        final cubit = context.read<PersonalProfileCubit>();
        final certifications = cubit.certificationsEntity?.certifications;

        if (certifications == null || certifications.isEmpty) {
          return Center(
              child: Text(context.localization.noCertificationsAvailable));
        }
        if (state is CertificationsLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: certifications
                .map((cert) => CertificationCard(
                      cert: cert,
                      formatDate: _formatDate,
                    ))
                .toList(),
          ),
        );
      },
    );
  }
}
