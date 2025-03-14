import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:short_path/config/routes/routes_name.dart';
import 'package:short_path/core/extensions/extensions.dart';
import 'package:short_path/core/styles/colors/app_colore.dart';
import 'package:short_path/dependency_injection/di.dart';
import 'package:short_path/src/presentation/mangers/home/home_viewmodel.dart';
import 'package:short_path/src/presentation/shared_widgets/custom_auth_button.dart';
import 'package:short_path/src/short_path.dart';

import '../../../../../core/styles/spacing.dart';
import '../../widgets/home/job_stats_card.dart';
import '../../widgets/home/offer_card.dart';
import '../../widgets/home/pagenated_page_list.dart';
import '../../widgets/home/skeleton_job_card.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final HomeViewmodel homeViewmodel = getIt<HomeViewmodel>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) {
        homeViewmodel.getUserData();
        homeViewmodel.getAllJobs();
        return homeViewmodel;
      },
      child: BlocConsumer<HomeViewmodel, HomeState>(
        listener: (context, state) {
          if (state is HomeInitial) {
            homeViewmodel.getUserData();
            homeViewmodel.getAllJobs();
          }
        },
        builder: (context, state) {
          if (state is SessionExpired || state is UserDataError) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  context.localization.sessionExpired,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                CustomAuthButton(
                  text: context.localization.goToLogin,
                  onPressed: () {
                    navKey.currentState!.pushNamedAndRemoveUntil(
                        RoutesName.login, (route) => false);
                  },
                  color: AppColors.primaryColor,
                ),
              ],
            );
          }
          if (state is UserDataError || state is JobsError) {
            final errorMessage = state is UserDataError
                ? state.message
                : (state as JobsError).message;
            return Center(
              child: Text(
                errorMessage,
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
                      Text(
                        context.localization.welcome,
                        style: const TextStyle(
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
                const OfferCard(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(context.localization.findYourJob,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 16),
                      JobStatsCard(),
                      verticalSpace(20),
                      Text(
                        context.localization.recentJobList,
                        style: const TextStyle(
                          color: Color(0xFF150B3D),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // If jobs list is null, show skeleton loaders.
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
                          : PaginatedJobList(
                              jobs: homeViewmodel.jobs!,
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
