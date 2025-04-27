import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/common/common_imports.dart';
import '../../../../../../../core/styles/spacing.dart';
import '../../../../../mangers/home/home_viewmodel.dart';
import '../skeleton_job_card.dart';
import 'job_card.dart';

class JobListWidget extends StatelessWidget {
  const JobListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var homeViewmodel = context.watch<HomeViewmodel>();
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Column(
        children: [
          if (homeViewmodel.jobs == null)
            ListView.separated(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => const SkeletonJobCard(),
              separatorBuilder: (_, __) => verticalSpace(16),
              itemCount: 5,
            )
          else
            ListView.separated(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) =>
                  JobCard(job: homeViewmodel.jobs![index]),
              separatorBuilder: (_, __) => verticalSpace(16),
              itemCount: 5,
            )
        ],
      ),
    );
  }
}
