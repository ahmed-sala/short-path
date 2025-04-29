import 'package:short_path/core/extensions/extensions.dart';

import '../../../../../../core/common/common_imports.dart';
import '../../../../mangers/home/jobs/jobs_viewmodel.dart';

class JobSearchWidget extends StatelessWidget {
  final TextEditingController searchController;
  final JobsViewmodel jobsViewmodel;

  const JobSearchWidget({
    super.key,
    required this.searchController,
    required this.jobsViewmodel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
          labelText: context.localization.search,
          border: const OutlineInputBorder(),
          prefixIcon: const Icon(Icons.search),
        ),
        onChanged: (query) => jobsViewmodel.getJobsForPage(0),
      ),
    );
  }
}
