import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:short_path/dependency_injection/di.dart';
import 'package:short_path/src/onboarding/presentation/widgets/dot_items.dart';

import '../../../../config/routes/routes_name.dart';
import '../../../../main.dart';
import '../../data/static/demo_data_list.dart';
import '../viewmodel/onboarding_state.dart';
import '../viewmodel/onboarding_viewmodel.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});

  OnboardingViewmodel _viewmodel = getIt<OnboardingViewmodel>();

  @override
  Widget build(BuildContext context) {
    final PageController _pageController = PageController();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: BlocProvider(
          create: (_) => _viewmodel,
          child: BlocBuilder<OnboardingViewmodel, OnboardingState>(
            builder: (context, state) {
              return Column(
                children: [
                  // Top Skip Button
                  if (_viewmodel.currentPage != demoData.length - 1)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              _viewmodel.skip();
                              navKey.currentState!
                                  .pushReplacementNamed(RoutesName.login);
                            },
                            child: const Text(
                              'Skip',
                              style: TextStyle(color: Colors.grey),
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
                            Image.asset(demoData[index].image),
                            const Spacer(flex: 2),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text(
                                demoData[index].title,
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text(
                                demoData[index].subtitle,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .color!
                                      .withOpacity(0.64),
                                ),
                              ),
                            ),
                            const Spacer(flex: 2),
                          ],
                        );
                      },
                    ),
                  ),

                  // Dots Indicator
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      demoData.length,
                      (index) => DotItems(
                        isActive: index == _viewmodel.currentPage,
                      ),
                    ),
                  ),
                  const Spacer(),

                  // Navigation Buttons
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Back Button
                        if (_viewmodel.currentPage > 0)
                          ElevatedButton(
                            onPressed: () {
                              _pageController.previousPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                              _viewmodel.changePage(_viewmodel.currentPage - 1);
                            },
                            child: const Text('Back'),
                          )
                        else
                          const SizedBox(
                              width: 60), // Placeholder for alignment

                        // Next Button
                        ElevatedButton(
                          onPressed: _viewmodel.currentPage <
                                  demoData.length - 1
                              ? () {
                                  _pageController.nextPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                  _viewmodel
                                      .changePage(_viewmodel.currentPage + 1);
                                }
                              : () {
                                  // Go to Login after the last page
                                  navKey.currentState!
                                      .pushReplacementNamed(RoutesName.login);
                                },
                          child: Text(
                            _viewmodel.currentPage < demoData.length - 1
                                ? 'Next'
                                : 'Get Started',
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16.0),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
