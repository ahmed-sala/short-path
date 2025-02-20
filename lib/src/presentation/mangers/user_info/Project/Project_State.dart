sealed class ProjectState {
  const ProjectState();
}

class ProjectInitialState extends ProjectState {
  const ProjectInitialState();
}

class ProjectUpdated extends ProjectState {}

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