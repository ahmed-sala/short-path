import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:short_path/src/presentation/mangers/onboarding/onboarding_viewmodel.dart';
import 'package:short_path/src/presentation/screens/screen/onboarding/widgets/next_back_buttons.dart';
import '../../../../../config/routes/routes_name.dart';
import '../../../../../dependency_injection/di.dart';
import '../../../../data/static_data/demo_data_list.dart';
import '../../../../short_path.dart';
import '../../../mangers/onboarding/onboarding_state.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});

  final OnboardingViewmodel onboardingViewmodel = getIt<OnboardingViewmodel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: BlocProvider(
          create: (_) => onboardingViewmodel,
          child: BlocConsumer<OnboardingViewmodel, OnboardingState>(
            listener: (context, state) {
              if (state is OnboardingFinished) {
                navKey.currentState!
                    .pushReplacementNamed(RoutesName.authDecision);
              }
            },
            builder: (context, state) {
              if (state is OnboardingPageChanged) {
                onboardingViewmodel.currentPageIndex = state.pageIndex;
              }

              return Column(
                children: [
                  if (onboardingViewmodel.currentPageIndex !=
                      demoData.length - 1)
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: TextButton(
                          onPressed: onboardingViewmodel.skip,
                          child: const Text('Skip'),
                        ),
                      ),
                    ),
                  Expanded(
                    flex: 4,
                    child: PageView.builder(
                      controller: onboardingViewmodel.pageController,
                      onPageChanged: onboardingViewmodel.changePage,
                      itemCount: demoData.length,
                      itemBuilder: (context, index) {
                        final item = demoData[index];
                        return Column(
                          children: [
                            const Spacer(flex: 2),
                            Image.asset(item.image, height: 250),
                            const Spacer(flex: 1),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24.0,
                              ),
                              child: Text(
                                item.title,
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24.0,
                              ),
                              child: Text(
                                item.subtitle,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .color!
                                      .withValues(alpha: 0.7),
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
                  NextBackButtons(
                    currentPage: onboardingViewmodel.currentPageIndex,
                    length: demoData.length,
                    onNext: onboardingViewmodel.next,
                    onBack: onboardingViewmodel.back,
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
