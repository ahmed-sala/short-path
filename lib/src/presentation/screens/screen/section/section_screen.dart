import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:short_path/core/extensions/extensions.dart';
import 'package:short_path/core/styles/colors/app_colore.dart';
import 'package:short_path/src/presentation/mangers/section/section_screen_states.dart';

import '../../../../../dependency_injection/di.dart';
import '../../../mangers/section/section_Screen_viewmodel.dart';

class SectionScreen extends StatelessWidget {
  SectionScreen({super.key});

  final SectionScreenViewmodel _viewModel = getIt.get<SectionScreenViewmodel>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _viewModel,
      child: BlocBuilder<SectionScreenViewmodel, SectionScreenState>(
        builder: (context, state) {
          return Scaffold(
            extendBody: true,
            body: NotificationListener<ScrollNotification>(
              onNotification: _viewModel.onScroll,
              child: _viewModel.currentScreen,
            ),
            // Wrap bottomNavigationBar with AnimatedSlide
            bottomNavigationBar: AnimatedSlide(
              offset: _viewModel.showBottomNav
                  ? const Offset(0, 0)
                  : const Offset(0, 1),
              duration: const Duration(milliseconds: 300),
              child: Theme(
                data: Theme.of(context).copyWith(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                ),
                child: Container(
                  padding: EdgeInsets.only(left: 8.w, right: 8.w, top: 16.h),
                  margin:
                      EdgeInsets.symmetric(horizontal: 32.w, vertical: 24.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(4, 4),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.r),
                    child: BottomNavigationBar(
                      currentIndex: _viewModel.currentIndex,
                      onTap: (index) {
                        _viewModel.updateCurrentIndex(index);
                      },
                      backgroundColor: Colors.white,
                      selectedItemColor: AppColors.primaryColor,
                      unselectedItemColor: Colors.black,
                      iconSize: 30.sp,
                      showSelectedLabels: true,
                      showUnselectedLabels: false,
                      selectedLabelStyle: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      unselectedLabelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      type: BottomNavigationBarType.fixed,
                      elevation: 15,
                      items: [
                        _buildBottomNavItem(
                          Icons.home_outlined,
                          context.localization.home,
                        ),
                        _buildBottomNavItem(
                          Icons.card_giftcard,
                          context.localization.career,
                        ),
                        _buildBottomNavItem(
                          Icons.collections_bookmark_outlined,
                          'Saved',
                        ),
                        _buildBottomNavItem(
                          Icons.person_2_outlined,
                          context.localization.profile,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavItem(IconData icon, String label) {
    return BottomNavigationBarItem(
      icon: Icon(
        icon,
        size: 24.w,
        color: Colors.black,
      ),
      activeIcon: Icon(
        icon,
        size: 30.w,
        color: AppColors.primaryColor,
      ),
      label: label,
    );
  }
}
