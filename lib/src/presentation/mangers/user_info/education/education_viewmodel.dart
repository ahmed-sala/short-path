import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:short_path/core/common/api/api_result.dart';
import 'package:short_path/src/data/api/core/error/error_handler.dart';
import 'package:short_path/src/domain/entities/user_info/education_detail_entity.dart';
import 'package:short_path/src/domain/entities/user_info/education_entity.dart';
import 'package:short_path/src/domain/usecases/user_info/user_info_usecase.dart';

import '../../../../data/static_data/demo_data_list.dart';
import '../../../../domain/entities/user_info/education_projects_entity.dart';
import '../../../screens/screen/user info/education_screen/education_projects_screen.dart';
import '../../../screens/screen/user info/education_screen/education_screen.dart';
import 'education_state.dart';

@injectable
class EducationViewmodelNew extends Cubit<EducationState> {
  final UserInfoUsecase _userInfoUsecase;

  EducationViewmodelNew(this._userInfoUsecase)
      : super(const EducationInitialState()) {
    _initializeListeners();
  }

  // Controllers
  final TextEditingController institutionName = TextEditingController();
  String? selectedDegree;
  final TextEditingController location = TextEditingController();
  final TextEditingController projectNameController = TextEditingController();
  final TextEditingController projectDescriptionController =
      TextEditingController();
  final TextEditingController projectLinkController = TextEditingController();
  final TextEditingController toolsTechnologiesController =
      TextEditingController();
  final TextEditingController fieldOfStudyController = TextEditingController();

  // List of tools/technologies
  List<String> tollsTechnologies = [];
  List<String> filteredToolSuggestions = [];

  // Form Keys
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<FormState> educationProjectFormKey = GlobalKey<FormState>();

  // Data Variables
  List<EducationDetailEntity> educationDetails = [];
  List<EducationProjectsEntity> projects = [];

  DateTime? selectedDate;
  bool validate = false;
  int currentPage = 0;

  // Screens
  final List<Widget> pages = [
    const EducationScreen(),
    const EducationProjectScreen(),
  ];

  void _initializeListeners() {
    projectNameController.addListener(_onInputChanged);
    projectDescriptionController.addListener(_onInputChanged);
    projectLinkController.addListener(_onInputChanged);
    toolsTechnologiesController.addListener(_onInputChanged);
    toolsTechnologiesController.addListener(onToolChanged);
  }

  void _onInputChanged() {
    validateColorButton();
  }

  void validateColorButton() {
    validate = institutionName.text.isNotEmpty &&
        location.text.isNotEmpty &&
        (formKey.currentState?.validate() ?? false);
    emit(const ValidateColorButtonState());
  }

  void onToolChanged() {
    final input = toolsTechnologiesController.text.toLowerCase();
    if (input.isEmpty) {
      filteredToolSuggestions = [];
    } else {
      filteredToolSuggestions = technicalSkills
          .where((tool) =>
              tool.toLowerCase().startsWith(input) &&
              !tollsTechnologies.contains(tool))
          .toList();
    }
    emit(const ToolsTechnologiesChanged());
  }

  void selectTool(String selectedTool) {
    // 1) Set the text field
    toolsTechnologiesController.text = selectedTool;
    // 2) Add to the list
    addToolsTechnologies(selectedTool);
    // 3) Clear suggestions
    filteredToolSuggestions = [];
    emit(const ToolsAndTechnologiesAdded());
  }

  void updateSelectedDegree(String? degree) {
    selectedDegree = degree;
    emit(const DegreeCertificationChanged());
    validateColorButton();
  }

  void updateSelectedDate(DateTime date) {
    selectedDate = date;
    emit(UpdateSelectedDateState(selectedDate));
    validateColorButton();
  }

  void addEducation() {
    changePage(0);
    educationDetails.add(
      EducationDetailEntity(
        degreeCertification: selectedDegree?.toUpperCase(),
        institutionName: institutionName.text,
        location: location.text,
        graduationDate: selectedDate,
        projects: List.from(projects) // Pass a copy of the projects list
        ,
        fieldOfStudy: fieldOfStudyController.text,
      ),
    );
    emit(const EducationAddedState());

    // Reset fields
    _clearEducationFields();
    projects = [];
  }

  void removeEducation(EducationDetailEntity education) {
    educationDetails.remove(education);
    emit(const RemoveEducationState());
  }

  void addProject() {
    if (tollsTechnologies.isEmpty) {
      emit(const AddEducationErrorState('Please add tools and technologies'));
      return;
    }
    if (educationProjectFormKey.currentState!.validate()) {
      projects.add(
        EducationProjectsEntity(
          projectName: projectNameController.text,
          projectDescription: projectDescriptionController.text,
          projectLink: projectLinkController.text,
          toolsTechnologies: List.from(tollsTechnologies),
        ),
      );

      // Reset form and clear fields
      educationProjectFormKey = GlobalKey<FormState>();
      _clearProjectFields();
      tollsTechnologies = [];
      emit(EducationProjectUpdated());
    }
  }

  void removeProject(EducationProjectsEntity project) {
    projects.remove(project);
    emit(EducationProjectUpdated());
  }

  void addProjectBack(EducationProjectsEntity project) {
    projects.add(project);
    emit(EducationProjectUpdated());
  }

  void changePage(int index) {
    if (currentPage != index) {
      currentPage = index;
      emit(const OnboardingNextState());
    }
  }

  void returnToPreviousPage() {
    changePage(0);
  }

  void nextButton() async {
    if (projects.isEmpty) {
      emit(const AddEducationErrorState('Please add projects'));
      return;
    }

    educationDetails.add(
      EducationDetailEntity(
        degreeCertification: selectedDegree?.toUpperCase(),
        institutionName: institutionName.text,
        location: location.text,
        graduationDate: selectedDate,
        projects: projects,
        fieldOfStudy: fieldOfStudyController.text,
      ),
    );
    emit(const AddEducationLoadingState());
    EducationEntity educationEntity = EducationEntity(
      educationDetails: educationDetails,
    );
    var result = await _userInfoUsecase.invokeEducation(
      educationEntity,
    );
    switch (result) {
      case Success<void>():
        emit(const AddEducationSuccessState());
      case Failures<void>():
        educationDetails.removeLast();
        var errorMessage =
            ErrorHandler.fromException(result.exception).errorMessage;
        emit(AddEducationErrorState(errorMessage));
    }
  }

  void addToolsTechnologies(String value) {
    if (value.isNotEmpty && !tollsTechnologies.contains(value)) {
      tollsTechnologies.add(value);
      toolsTechnologiesController.clear();
      emit(const ToolsAndTechnologiesAdded());
    }
  }

  // Remove tools/technologies from the list
  void removeToolsTechnologies(String value) {
    if (value.isNotEmpty) {
      tollsTechnologies.remove(value);
      emit(const ToolsAndTechnologiesRemoved());
    }
  }

  // Utility Methods
  void _clearEducationFields() {
    institutionName.clear();
    selectedDegree = null;
    fieldOfStudyController.clear();
    location.clear();
    selectedDate = null;
    _clearProjectFields();
  }

  void _clearProjectFields() {
    projectNameController.clear();
    projectDescriptionController.clear();
    projectLinkController.clear();
    toolsTechnologiesController.clear();
  }

  @override
  Future<void> close() {
    institutionName.dispose();
    location.dispose();
    projectNameController.dispose();
    projectDescriptionController.dispose();
    projectLinkController.dispose();
    toolsTechnologiesController.dispose();
    fieldOfStudyController.dispose();
    return super.close();
  }
}
