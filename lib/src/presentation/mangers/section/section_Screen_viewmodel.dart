import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:short_path/src/presentation/mangers/section/section_screen_states.dart';
import 'package:short_path/src/presentation/screens/screen/career/career_screen.dart';
import 'package:short_path/src/presentation/screens/screen/profile/personal_profile_screen.dart';
import 'package:short_path/src/presentation/screens/screen/saved_jobs/saved_jobs_screen.dart';

import '../../screens/screen/home/home_screen.dart';

@injectable
class SectionScreenViewmodel extends Cubit<SectionScreenState> {
  SectionScreenViewmodel() : super(HomeInitial());

  int _currentIndex = 0;

  // Expose current index
  int get currentIndex => _currentIndex;

  final List<String> _titles = [
    'Home',
    'Categories',
    'Cart',
    'Profile',
  ];

  List<Widget> get _screens => [
        HomeScreen(),
        const CareerScreen(),
        const SavedJobsScreen(),
        PersonalProfileScreen(),
      ];

  Widget get currentScreen => _screens[_currentIndex];

  void updateCurrentIndex(int index) {
    _currentIndex = index;
    emit(HomeStateUpdated());
  }

  bool _showBottomNav = true; // controls visibility

  get showBottomNav => _showBottomNav;

  bool onScroll(ScrollNotification notification) {
    if (notification is UserScrollNotification) {
      if (notification.direction == ScrollDirection.reverse && _showBottomNav) {
        _showBottomNav = false;
        emit(HomeStateUpdated());
      } else if (notification.direction == ScrollDirection.forward &&
          !_showBottomNav) {
        _showBottomNav = true;
        emit(HomeStateUpdated());
      }
    }
    return false;
  }
}
