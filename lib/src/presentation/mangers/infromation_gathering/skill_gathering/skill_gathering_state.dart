import '../../../../domain/entities/infromation_gathering/skill_entity.dart';

sealed class SkillGatheringState {
  const SkillGatheringState();
}

class InitialSkillGatheringState extends SkillGatheringState {
  const InitialSkillGatheringState();
}

class SkillAddedState extends SkillGatheringState {
  final List<SkillEntity> skills;

  SkillAddedState(this.skills);
}

class OnboardingNextState extends SkillGatheringState {
  const OnboardingNextState();
}

class SkillRemovedState extends SkillGatheringState {
  final List<SkillEntity> skills;

  SkillRemovedState(this.skills);
}
