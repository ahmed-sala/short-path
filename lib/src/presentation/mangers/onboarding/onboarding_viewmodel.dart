import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:short_path/src/presentation/mangers/onboarding/onboarding_state.dart';

@injectable
class OnboardingViewmodel extends Cubit<OnboardingState> {
  int currentPage = 0;
  final PageController _pageController = PageController();

  PageController get pageController => _pageController;

  OnboardingViewmodel() : super(const OnboardingInitial());

  void changePage(int index) {
    currentPage = index;
    emit(OnboardingPageChanged(index));
  }

  void skip() {
    emit(const OnboardingSkipState());
  }
}
