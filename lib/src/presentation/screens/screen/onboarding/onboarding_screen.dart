import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:short_path/dependency_injection/di.dart';

import '../../../../../../config/routes/routes_name.dart';
import '../../../../data/static_data/demo_data_list.dart';
import '../../../../short_path.dart';
import '../../../mangers/onboarding/onboarding_state.dart';
import '../../../mangers/onboarding/onboarding_viewmodel.dart';
import '../../widgets/onboarding/dot_items.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});

  final OnboardingViewmodel _viewmodel = getIt<OnboardingViewmodel>();

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
                              navKey.currentState!.pushReplacementNamed(
                                  RoutesName.authDecision);
                            },
                            child: const Text(
                              'Skip',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16.0,
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
                            Image.asset(demoData[index].image, height: 250),
                            const Spacer(flex: 2),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24.0),
                              child: Text(
                                demoData[index].title,
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24.0,
                                    ),
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24.0),
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
                                  height: 1.5,
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
                  const SizedBox(height: 24.0),

                  // Navigation Buttons
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Back Button
                        if (_viewmodel.currentPage > 0)
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                              ),
                              onPressed: () {
                                _pageController.previousPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                                _viewmodel
                                    .changePage(_viewmodel.currentPage - 1);
                              },
                              child: const Text('Back'),
                            ),
                          )
                        else
                          const SizedBox(width: 100),

                        const SizedBox(width: 16.0),

                        // Next or Get Started Button
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                            onPressed: _viewmodel.currentPage <
                                    demoData.length - 1
                                ? () {
                                    _pageController.nextPage(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut,
                                    );
                                    _viewmodel
                                        .changePage(_viewmodel.currentPage + 1);
                                  }
                                : () {
                                    navKey.currentState!.pushReplacementNamed(
                                        RoutesName.authDecision);
                                  },
                            child: Text(
                              _viewmodel.currentPage < demoData.length - 1
                                  ? 'Next'
                                  : 'Get Started',
                              style: const TextStyle(fontSize: 16.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24.0),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
