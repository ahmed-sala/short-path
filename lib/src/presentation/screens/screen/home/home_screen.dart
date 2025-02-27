import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:short_path/config/routes/routes_name.dart';
import 'package:short_path/core/styles/colors/app_colore.dart';
import 'package:short_path/dependency_injection/di.dart';
import 'package:short_path/src/presentation/mangers/home/home_viewmodel.dart';
import 'package:short_path/src/presentation/screens/widgets/home/job_card.dart';
import 'package:short_path/src/presentation/shared_widgets/custom_auth_button.dart';
import 'package:short_path/src/short_path.dart';

import '../../../../../core/styles/spacing.dart';
import '../../widgets/home/job_stats_card.dart';
import '../../widgets/home/offer_card.dart';
import '../../widgets/home/skeleton_job_card.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  HomeViewmodel homeViewmodel = getIt<HomeViewmodel>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) {
        homeViewmodel.getUserData();
        homeViewmodel.getAllJobs();
        return homeViewmodel;
      },
      child: BlocBuilder<HomeViewmodel, HomeState>(
        builder: (context, state) {
          if (state is SessionExpired) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Session Expired',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                CustomAuthButton(
                  text: 'Go to login',
                  onPressed: () {
                    navKey.currentState!.pushNamedAndRemoveUntil(
                        RoutesName.login, (route) => false);
                  },
                  color: AppColors.primaryColor,
                ),
              ],
            );
          }
          if (state is UserDataError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            );
          }
          if (state is JobsError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            );
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(
                      top: height * 0.06, left: 20, right: 20, bottom: 20),
                  decoration: const BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Welcome,',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '${homeViewmodel.appUser?.firstName ?? ''} ${homeViewmodel.appUser?.lastName ?? ''}',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Redesigned Offer Banner
                const OfferCard(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Find Your Job',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 16),
                      JobStatsCard(),
                      verticalSpace(20),
                      const Text(
                        'Recent Job List',
                        style: TextStyle(
                          color: Color(0xFF150B3D),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // Use Skeltonizer if the jobs list is null
                      homeViewmodel.jobs == null
                          ? ListView.separated(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return const SkeletonJobCard();
                              },
                              separatorBuilder: (context, index) =>
                                  verticalSpace(16),
                              itemCount: 5,
                            )
                          : ListView.separated(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return JobCard(
                                  job: homeViewmodel.jobs![index],
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  verticalSpace(8),
                              itemCount: 10,
                            ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
