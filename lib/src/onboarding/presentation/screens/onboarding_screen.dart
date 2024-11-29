import 'package:flutter/material.dart';
import '../../../../config/routes/routes_name.dart';

final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Onboard> demoData = [
    Onboard(
      image: 'assets/images/onboarding1.png',
      title: 'Track Your Progress',
      subtitle:
      'Monitor your job search journey and stay updated on applications and interviews.',
    ),
    Onboard(
      image: 'assets/images/onboarding2.png',
      title: 'Smart Recommendations',
      subtitle:
      'Get personalized job suggestions based on your experience and preferences.',
    ),
    Onboard(
      image: 'assets/images/onboarding3.png',
      title: 'AI-Powered Job Search',
      subtitle:
      'Leverage advanced AI to find the perfect job opportunities tailored to your skills.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            // PageView for onboarding items
            Expanded(
              flex: 4,
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: demoData.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      const Spacer(flex: 2),
                      Image.asset(demoData[index].image),
                      const Spacer(flex: 3),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0), // مسافة أفقية للنص العنوان
                        child: Text(
                          demoData[index].title,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                      const Spacer(flex: 3),
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
                    (index) => buildDot(index: index),
              ),
            ),
            const Spacer(),

            // Skip Button
            TextButton.icon(
              onPressed: () {
                navKey.currentState!.pushReplacementNamed(RoutesName.login);
              },
              icon: const Text("Skip"),
              label: const Icon(
                Icons.arrow_forward_ios,
                size: 20,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  // Dot Indicator Widget
  Widget buildDot({required int index}) {
    return Container(
      height: 10,
      width: _currentPage == index ? 20 : 10,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        color: _currentPage == index ? Colors.blue : Colors.grey,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}

class Onboard {
  final String image;
  final String title;
  final String subtitle;

  Onboard({
    required this.image,
    required this.title,
    required this.subtitle,
  });
}
