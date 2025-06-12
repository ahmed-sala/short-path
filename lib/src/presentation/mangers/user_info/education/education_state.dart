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

class EducationProjectUpdated extends EducationState {}

class ProjectNameChanged extends EducationState {
  const ProjectNameChanged();
}

class ProjectDescriptionChanged extends EducationState {
  const ProjectDescriptionChanged();
}

class ProjectLinkChanged extends EducationState {
  const ProjectLinkChanged();
}

class ToolsTechnologiesChanged extends EducationState {
  const ToolsTechnologiesChanged();
}

class ToolsAndTechnologiesAdded extends EducationState {
  const ToolsAndTechnologiesAdded();
}

class ToolsAndTechnologiesRemoved extends EducationState {
  const ToolsAndTechnologiesRemoved();
}

class ToolsAndTechnologiesSelected extends EducationState {
  const ToolsAndTechnologiesSelected();
}

class AddEducationLoadingState extends EducationState {
  const AddEducationLoadingState();
}

class AddEducationSuccessState extends EducationState {
  const AddEducationSuccessState();
}

class AddEducationErrorState extends EducationState {
  final String message;

  const AddEducationErrorState(this.message);
}

class DegreeCertificationChanged extends EducationState {
  const DegreeCertificationChanged();
}

/// Fired whenever the page changes
final class EducationPageChangedState extends EducationState {
  final int pageIndex;

  const EducationPageChangedState(this.pageIndex);
}
