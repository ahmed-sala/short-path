import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:short_path/src/presentation/mangers/onboarding/onboarding_state.dart';

@injectable
class OnboardingViewmodel extends Cubit<OnboardingState> {
  int currentPage = 0;
  final PageController _pageController = PageController();
  get pageController => _pageController;
  OnboardingViewmodel() : super(const OnboardingInitial());

  /// Updates the page index and emits the corresponding state
  void changePage(int index) {
    currentPage = index;
    emit(const OnboardingNextState()); // Emit state to notify listeners
  }

  /// Handles the skip action and emits the SkipState
  void skip() {
    emit(const OnboardingSkipState());
  }
}
