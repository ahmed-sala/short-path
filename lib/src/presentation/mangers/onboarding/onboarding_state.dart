sealed class OnboardingState {}

final class OnboardingInitial extends OnboardingState {}

final class OnboardingPageChanged extends OnboardingState {
  final int pageIndex;

  OnboardingPageChanged(this.pageIndex);
}

final class OnboardingFinished extends OnboardingState {}
