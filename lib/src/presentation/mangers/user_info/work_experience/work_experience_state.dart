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
  const WorkExperienceAdded();
}

class WorkExperienceRemoved extends WorkExperienceState {
  const WorkExperienceRemoved();
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

class ToolChanged extends WorkExperienceState {
  const ToolChanged();
}

class ToolSelected extends WorkExperienceState {
  const ToolSelected();
}

class StartDateSelected extends WorkExperienceState {
  final DateTime date;

  const StartDateSelected(this.date);
}

class EndDateSelected extends WorkExperienceState {
  final DateTime date;

  const EndDateSelected(this.date);
}

class JobTypeSelected extends WorkExperienceState {}

class JobLocationSelected extends WorkExperienceState {}

class AddWorkExperienceSuccess extends WorkExperienceState {
  const AddWorkExperienceSuccess();
}

class AddWorkExperienceFailed extends WorkExperienceState {
  final String message;

  const AddWorkExperienceFailed(this.message);
}

class AddWorkExperienceLoading extends WorkExperienceState {
  const AddWorkExperienceLoading();
}

class SessionExpired extends WorkExperienceState {
  const SessionExpired();
}

class CurrentlyWorkingChanged extends WorkExperienceState {
  final bool isCurrentlyWorking;

  const CurrentlyWorkingChanged(this.isCurrentlyWorking);
}
