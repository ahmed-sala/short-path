sealed class OnboardingState {
  const OnboardingState();
}

class OnboardingInitial extends OnboardingState {
  const OnboardingInitial();
}

class OnboardingNextState extends OnboardingState {
  const OnboardingNextState();
}

class OnboardingSkipState extends OnboardingState {
  const OnboardingSkipState();
}
