import 'package:equatable/equatable.dart';

abstract class OnboardingState extends Equatable {
  const OnboardingState();
}

class OnboardingInitial extends OnboardingState {
  const OnboardingInitial();

  @override
  List<Object> get props => [];
}

class OnboardingPageChanged extends OnboardingState {
  final int currentPage;

  const OnboardingPageChanged(this.currentPage);

  @override
  List<Object> get props => [currentPage];
}

class OnboardingSkipState extends OnboardingState {
  const OnboardingSkipState();

  @override
  List<Object> get props => [];
}
