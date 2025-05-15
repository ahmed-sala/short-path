import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../data/static_data/demo_data_list.dart';
import 'onboarding_state.dart';

@injectable
class OnboardingViewmodel extends Cubit<OnboardingState> {
  final PageController pageController = PageController();
  int currentPageIndex = 0;

  OnboardingViewmodel() : super(OnboardingInitial());

  void changePage(int pageIndex) {
    currentPageIndex = pageIndex;
    emit(OnboardingPageChanged(pageIndex));
  }

  void next() {
    if (currentPageIndex < demoData.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      changePage(currentPageIndex + 1);
    } else {
      finish();
    }
  }

  void back() {
    if (currentPageIndex > 0) {
      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      changePage(currentPageIndex - 1);
    }
  }

  void skip() {
    finish();
  }

  void finish() {
    emit(OnboardingFinished());
  }

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }
}
