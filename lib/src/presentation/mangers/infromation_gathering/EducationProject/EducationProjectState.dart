sealed class EducationProjectState {
  const EducationProjectState();
}

class EducationProjectInitialState extends EducationProjectState {
  const EducationProjectInitialState();
}

class EducationProjectLoading extends EducationProjectState {
  const EducationProjectLoading();
}

class EducationProjectUpdated extends EducationProjectState {}

class ProjectNameChanged extends EducationProjectState {
  const ProjectNameChanged();
}

class ProjectDescriptionChanged extends EducationProjectState {
  const ProjectDescriptionChanged();
}

class ProjectLinkChanged extends EducationProjectState {
  const ProjectLinkChanged();
}

class ToolsTechnologiesChanged extends EducationProjectState {
  const ToolsTechnologiesChanged();
}

class ValidateColorButtonState extends EducationProjectState {
  final bool validate;
  const ValidateColorButtonState({required this.validate});
}