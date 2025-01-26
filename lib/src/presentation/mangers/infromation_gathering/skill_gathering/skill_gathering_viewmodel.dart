import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:short_path/src/presentation/mangers/infromation_gathering/skill_gathering/skill_gathering_state.dart';
import 'package:short_path/src/presentation/screens/screen/user%20info/skiils/industry_specfic_skills_screen.dart';
import 'package:short_path/src/presentation/screens/screen/user%20info/skiils/soft_skill_screen.dart';

import '../../../../domain/entities/infromation_gathering/skill_entity.dart';
import '../../../screens/screen/user info/skiils/technical_skill_screen.dart';

@injectable
class SkillGatheringViewmodel extends Cubit<SkillGatheringState> {
  SkillGatheringViewmodel() : super(InitialSkillGatheringState());
  final TextEditingController techSkillController = TextEditingController();
  final TextEditingController softSkillController = TextEditingController();
  final TextEditingController industrySpecificSkillController =
      TextEditingController();

  final List<SkillEntity> _techSkills = [];
  List<SkillEntity> get techSkills => _techSkills;
  final List<String> _softSkills = [];
  List<String> get softSkills => _softSkills;
  final List<String> _industrySkills = [];
  List<String> get industrySkills => _industrySkills;

  String selectedProficiency = 'Beginner';
  List<String> filteredSuggestions = [];
  int currentPage = 0;

  List<Widget> pages = [
    TechnicalSkillScreen(),
    SoftSkillScreen(),
    IndustrySpecificSkillsScreen(),
  ];

  void addSkill(
      {required String skill, String? proficiency, required String type}) {
    if (type == 'Technical') {
      _techSkills.add(SkillEntity(skill: skill, proficiency: proficiency));
      emit(SkillAddedState(techSkills: _techSkills));
    } else if (type == 'Soft') {
      _softSkills.add(skill);
      emit(SkillAddedState(softSkills: _softSkills));
    } else if (type == 'Industry') {
      _industrySkills.add(skill);
      emit(SkillAddedState(industrySkills: _industrySkills));
    }
  }

  void changePage(int index) {
    currentPage = index;
    filteredSuggestions = [];
    emit(OnboardingNextState()); // Emit state to notify listeners
  }

  void removeSkill(
      {required String skill, required String type, String? proficiency}) {
    if (type == 'Technical') {
      _techSkills
          .removeWhere((s) => s.skill == skill && s.proficiency == proficiency);
      emit(SkillRemovedState(techSkills: _techSkills));
    } else if (type == 'Soft') {
      _softSkills.remove(skill);
      emit(SkillRemovedState(softSkills: _softSkills));
    } else if (type == 'Industry') {
      _industrySkills.remove(skill);
      emit(SkillRemovedState(industrySkills: _industrySkills));
    }
  }

  @override
  Future<void> close() {
    techSkillController.dispose();
    softSkillController.dispose();
    industrySpecificSkillController.dispose();
    return super.close();
  }
}
