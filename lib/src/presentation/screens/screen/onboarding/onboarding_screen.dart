import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:short_path/core/extensions/extensions.dart';
import 'package:short_path/core/styles/colors/app_colore.dart';
import 'package:short_path/dependency_injection/di.dart';
import 'package:short_path/src/presentation/shared_widgets/next_back_buttuns.dart';

import '../../../../../../config/routes/routes_name.dart';
import '../../../../../core/styles/spacing.dart';
import '../../../../data/static_data/demo_data_list.dart';
import '../../../../short_path.dart';
import '../../../mangers/onboarding/onboarding_state.dart';
import '../../../mangers/onboarding/onboarding_viewmodel.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});

  final OnboardingViewmodel _viewmodel = getIt<OnboardingViewmodel>();
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: BlocProvider(
          create: (_) => _viewmodel,
          child: BlocBuilder<OnboardingViewmodel, OnboardingState>(
            builder: (context, state) {
              // Extract currentPage from the state
              int currentPage = 0;
              if (state is OnboardingPageChanged) {
                currentPage = state.currentPage;
              } else if (state is OnboardingInitial) {
                currentPage = 0;
              }

              return Column(
                children: [
                  // Top Skip Button
                  if (currentPage != demoData.length - 1)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              _viewmodel.skip();
                              navKey.currentState!.pushReplacementNamed(
                                  RoutesName.authDecision);
                            },
                            child: Text(
                              context.localization.skip,
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontSize: 16.0.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                  // PageView for onboarding items
                  Expanded(
                    flex: 4,
                    child: PageView.builder(
                      controller: _pageController,
                      onPageChanged: (index) {
                        _viewmodel.changePage(index);
                      },
                      itemCount: demoData.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            const Spacer(flex: 2),
                            Image.asset(demoData[index].image, height: 250.h),
                            const Spacer(flex: 2),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                              child: Text(
                                demoData[index].title,
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24.0.sp,
                                    ),
                              ),
                            ),
                            verticalSpace(16),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                              child: Text(
                                demoData[index].subtitle,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .color!
                                      .withOpacity(0.7),
                                  fontSize: 16.0,
                                  height: 1.5.h,
                                ),
                              ),
                            ),
                            const Spacer(flex: 2),
                          ],
                        );
                      },
                    ),
                  ),

                  // Dots Indicator and Buttons
                  NextBackButtuns(
                    finish: () {
                      navKey.currentState!
                          .pushReplacementNamed(RoutesName.authDecision);
                    },
                    length: demoData.length,
                    changePage: _viewmodel.changePage,
                    currentPage: currentPage, // Use state-derived currentPage
                    pageController: _pageController,
                  ),
                  verticalSpace(24),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
