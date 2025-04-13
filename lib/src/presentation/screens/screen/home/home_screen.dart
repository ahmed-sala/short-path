import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:short_path/core/extensions/extensions.dart';
import 'package:short_path/dependency_injection/di.dart';
import 'package:short_path/src/presentation/mangers/home/home_viewmodel.dart';
import 'package:short_path/src/presentation/screens/widgets/home/home_header_widget.dart';
import 'package:short_path/src/presentation/screens/widgets/home/no_jobs_widget.dart';
import 'package:short_path/src/presentation/screens/widgets/home/recent_row_widget.dart';
import 'package:short_path/src/presentation/screens/widgets/home/session_expiration_widget.dart';

import '../../../../../core/styles/spacing.dart';
import '../../widgets/home/job_list_widget.dart';
import '../../widgets/home/job_stats_card.dart';
import '../../widgets/home/offer_card.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final HomeViewmodel homeViewmodel = getIt<HomeViewmodel>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        homeViewmodel.getUserData();
        homeViewmodel.getAllJobs();
        return homeViewmodel;
      },
      child: BlocBuilder<HomeViewmodel, HomeState>(
        builder: (context, state) {
          if (state is SessionExpired || state is UserDataError) {
            return const SessionExpirationWidget();
          }
          if (state is JobsError || state is UserDataError) {
            return Center(
              child: Text(
                (state as dynamic).message,
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            );
          }
          return _buildHomeContent(context);
        },
      ),
    );
  }

  Widget _buildHomeContent(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const HomeHeaderWidget(),
          const SizedBox(height: 20),
          const OfferCard(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.localization.findYourJob,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    JobStatsCard(viewModel: homeViewmodel),
                    verticalSpace(20),
                  ],
                ),
                const RecentRowWidget(),
                homeViewmodel.jobs == null
                    ? const JobListWidget()
                    : const NoJobsWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
