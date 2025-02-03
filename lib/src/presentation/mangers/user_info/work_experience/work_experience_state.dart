part of 'work_experience_viewmodel.dart';

@immutable
sealed class WorkExperienceState {

  const WorkExperienceState();
}

class WorkExperienceInitial extends WorkExperienceState {
  const WorkExperienceInitial();
}

class WorkExperienceChanged extends WorkExperienceState {
  const WorkExperienceChanged();
}

class WorkExperienceLoading extends WorkExperienceState {
  const WorkExperienceLoading();
}

class WorkExperienceAdded extends WorkExperienceState {
  final WorkExperienceEntity workExperience;

  const WorkExperienceAdded(this.workExperience);
}

class WorkExperienceRemoved extends WorkExperienceState {
  final WorkExperienceEntity workExperience;

  const WorkExperienceRemoved(this.workExperience);
}

class WorkExperienceError extends WorkExperienceState {
  final String message;

  const WorkExperienceError(this.message);
}

class ToolAdded extends WorkExperienceState {
  final String tool;

  const ToolAdded(this.tool);
}

class ToolRemoved extends WorkExperienceState {
  final String tool;

  const ToolRemoved(this.tool);
}
