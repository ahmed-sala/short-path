import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:short_path/src/presentation/mangers/infromation_gathering/skill_gathering/skill_gathering_state.dart';

import '../../../../domain/entities/infromation_gathering/skill_entity.dart';

@injectable
class SkillGatheringViewmodel extends Cubit<SkillGatheringState> {
  SkillGatheringViewmodel() : super(InitialSkillGatheringState());
  final TextEditingController skillController = TextEditingController();

  final List<SkillEntity> _skills = [];
  List<SkillEntity> get skills => _skills;
  String selectedProficiency = 'Beginner';
  List<String> filteredSuggestions = [];

  final List<String> _technicalSkills = [
    'Flutter',
    'Dart',
    'Firebase',
    'REST API',
    'Bloc',
    'Provider',
    'GetX',
    'SQLite',
    'Git',
    'CI/CD',
  ];

  List<String> get technicalSkills => _technicalSkills;

  void addSkill(SkillEntity skill) {
    _skills.add(skill);
    emit(SkillAddedState(_skills));
  }

  void removeSkill(SkillEntity skill) {
    _skills.remove(skill);
    emit(SkillRemovedState(_skills));
  }

  @override
  Future<void> close() {
    skillController.dispose();
    return super.close();
  }
}
