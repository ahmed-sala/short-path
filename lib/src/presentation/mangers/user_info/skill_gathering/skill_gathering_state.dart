import '../../../../domain/entities/user_info/tech_skill_entity.dart';

sealed class SkillGatheringState {
  const SkillGatheringState();
}

class InitialSkillGatheringState extends SkillGatheringState {
  const InitialSkillGatheringState();
}
/// Fired whenever the page changes
final class SkillPageChangedState extends SkillGatheringState {
  final int pageIndex;
  const SkillPageChangedState(this.pageIndex);
}

class SkillAddedState extends SkillGatheringState {
  final List<TechnicalSkillEntity>? techSkills;
  final List<String>? softSkills;
  final List<String>? industrySkills;

  SkillAddedState({this.techSkills, this.softSkills, this.industrySkills});
}

class OnboardingNextState extends SkillGatheringState {
  const OnboardingNextState();
}

class SkillRemovedState extends SkillGatheringState {
  final List<TechnicalSkillEntity>? techSkills;
  final List<String>? softSkills;
  final List<String>? industrySkills;

  SkillRemovedState({this.techSkills, this.softSkills, this.industrySkills});
}

class SkillsAddedSuccessState extends SkillGatheringState {
  const SkillsAddedSuccessState();
}

class SkillsAddedFailureState extends SkillGatheringState {
  final String message;

  SkillsAddedFailureState(this.message);
}

class SkillsAddedLoadingState extends SkillGatheringState {
  const SkillsAddedLoadingState();
}
