sealed class ProjectState {
  const ProjectState();
}

class ProjectInitialState extends ProjectState {
  const ProjectInitialState();
}

class ProjectLoading extends ProjectState {
  const ProjectLoading();
}

class ProjectUpdated extends ProjectState {}

class ProjectTitleChanged extends ProjectState {
  const ProjectTitleChanged();
}

class RoleChanged extends ProjectState {
  const RoleChanged();
}

class DescriptionChanged extends ProjectState {
  const DescriptionChanged();
}

class TechnologiesUsedChanged extends ProjectState {
  const TechnologiesUsedChanged();
}

class ValidateColorButtonState extends ProjectState {
  final bool validate;
  const ValidateColorButtonState({required this.validate});
}

class AddProjectLoading extends ProjectState {
  const AddProjectLoading();
}

class AddProjectSuccess extends ProjectState {
  const AddProjectSuccess();
}

class AddProjectFailure extends ProjectState {
  final String error;
  const AddProjectFailure({required this.error});
}
