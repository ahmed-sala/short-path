import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:short_path/core/extensions/extensions.dart';
import 'package:short_path/dependency_injection/di.dart';
import 'package:short_path/src/presentation/mangers/home/home_viewmodel.dart';
import 'package:short_path/src/presentation/screens/screen/home/widgets/home_header_widget.dart';
import 'package:short_path/src/presentation/screens/screen/home/widgets/job_stats_card.dart';
import 'package:short_path/src/presentation/screens/screen/home/widgets/offer_card.dart';
import 'package:short_path/src/presentation/screens/screen/home/widgets/recent_row_widget.dart';
import 'package:short_path/src/presentation/shared_widgets/session_expiration_widget.dart';

import '../../../../../core/styles/spacing.dart';
import '../job/widgets/job_list_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

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
                    const JobStatsCard(),
                    verticalSpace(20),
                  ],
                ),
                const RecentRowWidget(),
                const JobListWidget()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
