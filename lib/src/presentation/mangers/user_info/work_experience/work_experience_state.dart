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
  const ToolAdded();
}

class ToolRemoved extends WorkExperienceState {
  const ToolRemoved();
}

class StartDateSelected extends WorkExperienceState {
  final DateTime date;

  const StartDateSelected(this.date);
}

class EndDateSelected extends WorkExperienceState {
  final DateTime date;

  const EndDateSelected(this.date);
}
