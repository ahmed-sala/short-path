import '../../../../domain/entities/infromation_gathering/skill_entity.dart';

sealed class SkillGatheringState {
  const SkillGatheringState();
}

class InitialSkillGatheringState extends SkillGatheringState {
  const InitialSkillGatheringState();
}

class SkillAddedState extends SkillGatheringState {
  final List<SkillEntity>? techSkills;
  final List<String>? softSkills;
  final List<String>? industrySkills;

  SkillAddedState({this.techSkills, this.softSkills, this.industrySkills});
}

class OnboardingNextState extends SkillGatheringState {
  const OnboardingNextState();
}

class SkillRemovedState extends SkillGatheringState {
  final List<SkillEntity>? techSkills;
  final List<String>? softSkills;
  final List<String>? industrySkills;

  SkillRemovedState({this.techSkills, this.softSkills, this.industrySkills});
}
