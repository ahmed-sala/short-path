import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:short_path/src/data/static_data/demo_data_list.dart';
import 'package:short_path/src/domain/entities/user_info/skill_entity.dart';
import 'package:short_path/src/domain/usecases/user_info/user_info_usecase.dart';
import 'package:short_path/src/presentation/mangers/user_info/skill_gathering/skill_gathering_state.dart';
import 'package:short_path/src/presentation/screens/screen/user%20info/skiils/industry_specfic_skills_screen.dart';
import 'package:short_path/src/presentation/screens/screen/user%20info/skiils/soft_skill_screen.dart';

import '../../../../../core/common/api/api_result.dart';
import '../../../../data/api/core/error/error_handler.dart';
import '../../../../domain/entities/user_info/tech_skill_entity.dart';
import '../../../screens/screen/user info/skiils/technical_skill_screen.dart';

@injectable
class SkillGatheringViewmodel extends Cubit<SkillGatheringState> {
  final UserInfoUsecase _userInfoUsecase;
  SkillGatheringViewmodel(this._userInfoUsecase)
      : super(const InitialSkillGatheringState());
  final TextEditingController techSkillController = TextEditingController();
  final TextEditingController softSkillController = TextEditingController();
  final TextEditingController industrySpecificSkillController =
      TextEditingController();

  final List<TechnicalSkillEntity> _techSkills = [];
  List<TechnicalSkillEntity> get techSkills => _techSkills;
  final List<String> _softSkills = [];
  List<String> get softSkills => _softSkills;
  final List<String> _industrySkills = [];
  List<String> get industrySkills => _industrySkills;

  String? selectedProficiency;
  List<String> filteredSuggestions = [];
  final PageController pageController = PageController();

  int currentPage = 0;

  List<Widget> pages = [
    const TechnicalSkillScreen(),
    const SoftSkillScreen(),
    const IndustrySpecificSkillsScreen(),
  ];

  void addSkill(
      {required String skill, String? proficiency, required String type}) {
    if (type == 'Technical') {
      var techSkill = TechnicalSkillEntity(
          skill: skill, proficiency: proficiency?.toUpperCase());
      _techSkills.add(techSkill);
      technicalSkills.remove(skill);

      emit(SkillAddedState(techSkills: _techSkills));
    } else if (type == 'Soft') {
      _softSkills.add(skill);
      emit(SkillAddedState(softSkills: _softSkills));
    } else if (type == 'Industry') {
      _industrySkills.add(skill);
      industrySpecificSkills.remove(skill);
      emit(SkillAddedState(industrySkills: _industrySkills));
    }
  }

  // Paging
  void changePage(int index) {
    currentPage = index;
    emit(SkillPageChangedState(index));
  }

  void nextPage() {
    if (currentPage < pages.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      changePage(currentPage + 1);
    }
  }

  void previousPage() {
    if (currentPage > 0) {
      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      changePage(currentPage - 1);
    }
  }


  void removeSkill(
      {required String skill, required String type, String? proficiency}) {
    if (type == 'Technical') {
      _techSkills.removeWhere((s) =>
          s.skill == skill && s.proficiency == proficiency?.toUpperCase());
      technicalSkills.add(skill);
      emit(SkillRemovedState(techSkills: _techSkills));
    } else if (type == 'Soft') {
      _softSkills.remove(skill);
      emit(SkillRemovedState(softSkills: _softSkills));
    } else if (type == 'Industry') {
      _industrySkills.remove(skill);
      industrySpecificSkills.add(skill);
      emit(SkillRemovedState(industrySkills: _industrySkills));
    }
  }

  void addAllSkills() async {
    emit(const SkillsAddedLoadingState());
    try {
      SkillEntity skills = SkillEntity(
        technicalSkills: _techSkills,
        softSkills: _softSkills,
        industrySpecificSkills: _industrySkills,
      );
      var result = await _userInfoUsecase.invokeSkills(skills);
      switch (result) {
        case Success<void>():
          emit(const SkillsAddedSuccessState());
          break;
        case Failures<void>():
          final error = ErrorHandler.fromException(result.exception);
          emit(SkillsAddedFailureState(error.errorMessage));
          break;
      }
    } catch (e) {
      emit(SkillsAddedFailureState(e.toString()));
    }
  }

  @override
  Future<void> close() {
    pageController.dispose();

    techSkillController.dispose();
    softSkillController.dispose();
    industrySpecificSkillController.dispose();
    return super.close();
  }
}
