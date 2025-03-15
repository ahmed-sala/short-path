import '../../../../../core/common/common_imports.dart';
import '../../../mangers/home/jobs/jobs_viewmodel.dart';

class JobSearchWidget extends StatelessWidget {
  final TextEditingController searchController;
  final JobsViewmodel jobsViewmodel;

  const JobSearchWidget({
    Key? key,
    required this.searchController,
    required this.jobsViewmodel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: searchController,
        decoration: const InputDecoration(
          labelText: "Search",
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.search),
        ),
        onChanged: (query) => jobsViewmodel.getJobsForPage(0),
      ),
    );
  }
}
