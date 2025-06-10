import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:short_path/dependency_injection/di.dart';
import 'package:short_path/src/presentation/mangers/saved_jobs/saved_jobs_cubit.dart';

import '../../../../../core/common/common_imports.dart';
import '../../../../../core/styles/animations/app_animation.dart';
import '../../../../../core/styles/spacing.dart';
import '../../../../domain/entities/home/jobs_entity.dart';
import '../../../shared_widgets/skeleton_job_card.dart';
import '../job/widgets/job_card.dart';

class SavedJobsScreen extends StatefulWidget {
  const SavedJobsScreen({super.key});

  @override
  State<SavedJobsScreen> createState() => _SavedJobsScreenState();
}

class _SavedJobsScreenState extends State<SavedJobsScreen> {
  SavedJobsCubit savedJobsCubit = getIt<SavedJobsCubit>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    savedJobsCubit.getSavedJobs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider.value(
        value: savedJobsCubit,
        child: BlocBuilder<SavedJobsCubit, SavedJobsState>(
          builder: (context, state) {
            final savedJobsCubit = context.read<SavedJobsCubit>();
            final jobs = savedJobsCubit.savedJobs;
            if (state is SavedJobsLoading) {
              return Center(
                child: Lottie.asset(
                  AppAnimation.loading,
                  width: 200,
                ),
              );
            }
            return SafeArea(
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: jobs == null
                      ? _buildLoading()
                      : jobs.isEmpty
                          ? _buildEmptyState()
                          : _buildJobList(jobs, savedJobsCubit),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildLoading() {
    return ListView.separated(
      itemBuilder: (context, index) => const SkeletonJobCard(),
      separatorBuilder: (_, __) => verticalSpace(16),
      itemCount: 5,
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.bookmark_border, size: 80, color: Colors.grey),
          verticalSpace(16),
          Text(
            'No saved jobs yet!',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
          verticalSpace(8),
          Text(
            'Your saved jobs will appear here.',
            style: TextStyle(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildJobList(List<ContentEntity> jobs, SavedJobsCubit cubit) {
    return ListView.separated(
      itemBuilder: (context, index) => JobCard(
        job: jobs[index],
        onBookmarkToggle: (job) {
          if (jobs[index].isSaved == true) {
            jobs[index].isSaved = false;
            cubit.removeJobFromFavorite(job);
            cubit.savedJobs!.removeAt(index);
          } else {
            jobs[index].isSaved = true;
            cubit.saveJobToFavorite(job);
          }
        },
      ),
      separatorBuilder: (_, __) => verticalSpace(16),
      itemCount: jobs.length,
    );
  }
}
