sealed class EducationState {
  const EducationState();
}

class EducationInitialState extends EducationState {
  const EducationInitialState();
}

class ValidateColorButtonState extends EducationState {
  const ValidateColorButtonState();
}

class DateUpdatedState extends EducationState {
  const DateUpdatedState();
}

class RemoveEducationState extends EducationState {
  const RemoveEducationState();
}

class EducationAddedState extends EducationState {
  const EducationAddedState();
}

class OnboardingNextState extends EducationState {
  const OnboardingNextState();
}

class UpdateSelectedDateState extends EducationState {
  final DateTime? selectedDate;
  const UpdateSelectedDateState(this.selectedDate);
}
