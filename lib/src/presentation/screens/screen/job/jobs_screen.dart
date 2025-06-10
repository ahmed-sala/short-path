import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:short_path/core/extensions/extensions.dart';
import 'package:short_path/src/presentation/screens/screen/job/widgets/job_card.dart';
import 'package:short_path/src/presentation/screens/screen/job/widgets/job_search_widget.dart';

import '../../../../../core/common/common_imports.dart';
import '../../../../../dependency_injection/di.dart';
import '../../../../domain/entities/home/jobs_entity.dart';
import '../../../mangers/home/jobs/jobs_viewmodel.dart';
import '../../../shared_widgets/skeleton_job_card.dart';
import 'widgets/pagination_controls.dart';

class JobsScreen extends StatefulWidget {
  const JobsScreen({super.key});

  @override
  State<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
  final JobsViewmodel jobsViewmodel = getIt<JobsViewmodel>();
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    jobsViewmodel.getJobsForPage(0);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.localization.jobs),
          actions: [
            IconButton(
                icon: const Icon(Icons.search),
                onPressed: () => setState(() => _isSearching = !_isSearching))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocProvider(
            create: (context) => jobsViewmodel,
            child: BlocBuilder<JobsViewmodel, JobsState>(
              builder: (context, state) {
                return Column(
                  children: [
                    if (_isSearching)
                      JobSearchWidget(
                          searchController: jobsViewmodel.searchController,
                          jobsViewmodel: jobsViewmodel),
                    const SizedBox(height: 16),
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: state is AllJobsLoading &&
                                    jobsViewmodel.jobs.isEmpty
                                ? ListView.separated(
                                    itemCount: 5,
                                    itemBuilder: (_, __) =>
                                        const SkeletonJobCard(),
                                    separatorBuilder: (_, __) =>
                                        const SizedBox(height: 8),
                                  )
                                : ListView.separated(
                                    itemCount: jobsViewmodel.jobs.length,
                                    itemBuilder: (_, index) => JobCard(
                                      job: jobsViewmodel.jobs[index],
                                      onBookmarkToggle: (ContentEntity job) {
                                        if (jobsViewmodel.jobs[index].isSaved ==
                                            true) {
                                          jobsViewmodel.jobs[index].isSaved =
                                              false;
                                          jobsViewmodel
                                              .removeJobFromFavorite(job);
                                        } else {
                                          jobsViewmodel.jobs[index].isSaved =
                                              true;
                                          jobsViewmodel.saveJobToFavorite(job);
                                        }
                                      },
                                    ),
                                    separatorBuilder: (_, __) =>
                                        const SizedBox(height: 8),
                                  ),
                          ),
                          const SizedBox(height: 16),
                          PaginationControls(jobsViewmodel: jobsViewmodel),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
