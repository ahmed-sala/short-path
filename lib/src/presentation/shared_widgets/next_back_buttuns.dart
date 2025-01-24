import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../screens/widgets/onboarding/dot_items.dart';

class NextBackButtuns extends StatelessWidget {
  const NextBackButtuns(
      {super.key,
      required this.finish,
      required this.pageController,
      required this.length,
      required this.changePage,
      required this.currentPage});
  final int currentPage;
  final PageController pageController;
  final void Function(int) changePage;
  final int length;
  final void Function() finish;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            length,
            (index) => DotItems(
              isActive: index == currentPage,
            ),
          ),
        ),
        const SizedBox(height: 24.0), // Fixed the vertical space here

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (currentPage > 0)
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16.0.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0.r),
                      ),
                      side: BorderSide(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    onPressed: () {
                      pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                      changePage(currentPage - 1);
                    },
                    child: Text(
                      'Back',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 16.0.sp,
                      ),
                    ),
                  ),
                ),
              if (currentPage > 0) SizedBox(width: 16.0.w),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16.0.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0.r),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  onPressed: currentPage < length - 1
                      ? () {
                          pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                          changePage(currentPage + 1);
                        }
                      : finish,
                  child: Text(
                    currentPage < length - 1 ? 'Next' : 'Get Started',
                    style: TextStyle(
                      fontSize: 16.0.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
