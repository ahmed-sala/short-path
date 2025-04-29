import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:short_path/core/common/api/api_result.dart';
import 'package:short_path/src/data/api/core/error/error_handler.dart';
import 'package:short_path/src/data/static_data/demo_data_list.dart';
import 'package:short_path/src/domain/entities/user_info/work_experience_entity.dart';
import 'package:short_path/src/domain/usecases/user_info/user_info_usecase.dart';
import 'package:short_path/src/presentation/mangers/user_info/work_experience/work_experience_state.dart';

@injectable
class WorkExperienceViewModel extends Cubit<WorkExperienceState> {
  UserInfoUsecase userInfoUsecase;

  WorkExperienceViewModel(this.userInfoUsecase)
      : super(const WorkExperienceInitial()) {
    toolController.addListener(onToolChanged);
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController jobTitleController = TextEditingController();
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController companyFieldController = TextEditingController();
  final TextEditingController summaryController = TextEditingController();
  final TextEditingController toolController = TextEditingController();

  DateTime? startDate;
  DateTime? endDate;
  List<WorkExperienceEntity> workExperiences = [];
  List<String> tollsTechnologies = [];
  List<String> filteredToolSuggestions = [];
  String? selectedJobType;
  String? selectedJobLocation;

  bool isValid = false;
  bool isCurrentlyWorking = false;

  List<String> jobTypes = [
    'Full_Time',
    'Part_Time',
    'Contract',
    'Internship',
  ];

  List<String> jobLocations = [
    'Remote',
    'Onsite',
    'Hybrid',
  ];

  void setCurrentlyWorking(bool value) {
    isCurrentlyWorking = value;
    if (value) {
      endDate = null;
    }
    emit(CurrentlyWorkingChanged(isCurrentlyWorking));
  }

  void onToolChanged() {
    final input = toolController.text.toLowerCase();
    if (input.isEmpty) {
      filteredToolSuggestions = [];
    } else {
      filteredToolSuggestions = technicalSkills
          .where((tool) =>
              tool.toLowerCase().startsWith(input) &&
              !tollsTechnologies.contains(tool))
          .toList();
    }
    emit(ToolsTechnologiesChanged());
  }

  void _validateForm() {
    final bool allFieldsFilled = jobTitleController.text.isNotEmpty &&
        companyNameController.text.isNotEmpty &&
        companyFieldController.text.isNotEmpty &&
        selectedJobLocation != null &&
        selectedJobType != null &&
        startDate != null &&
        (isCurrentlyWorking || endDate != null) &&
        summaryController.text.isNotEmpty;

    if (isValid != allFieldsFilled) {
      isValid = allFieldsFilled;
      emit(const WorkExperienceChanged());
    }
  }

  Future<void> next() async {
    if (workExperiences.isNotEmpty) {
      try {
        emit(const AddWorkExperienceLoading());
        final result =
            await userInfoUsecase.invokeWorkExperience(workExperiences);
        switch (result) {
          case Success<void>():
            emit(const AddWorkExperienceSuccess());
          case Failures<void>():
            var errorMessage = ErrorHandler.fromException(result.exception);
            if (errorMessage.code == 403) {
              emit(const SessionExpired());
              return;
            }
            emit(AddWorkExperienceFailed(errorMessage.errorMessage));
        }
      } catch (e) {
        emit(const AddWorkExperienceFailed(
            'An error occurred. Please try again.'));
      }
    }
  }

  void selectJobType(String? value) {
    selectedJobType = value;
    emit(JobTypeSelected());
  }

  void selectJobLocation(String? value) {
    selectedJobLocation = value;
    emit(JobLocationSelected());
  }

  void selectStartDate(DateTime date) {
    startDate = date;
    emit(StartDateSelected(startDate!));
  }

  void selectEndDate(DateTime date) {
    endDate = date;
    emit(EndDateSelected(endDate!));
  }

  void _resetForm() {
    jobTitleController.clear();
    companyNameController.clear();
    companyFieldController.clear();
    summaryController.clear();
    toolController.clear();
    tollsTechnologies.clear();
    selectedJobType = null;
    selectedJobLocation = null;
    startDate = null;
    endDate = null;
    isCurrentlyWorking = false;
    formKey = GlobalKey<FormState>();
  }

  void selectTool(String selectedTool) {
    toolController.text = selectedTool;
    addToolsTechnologies(selectedTool);
    filteredToolSuggestions = [];
    emit(const ToolsAndTechnologiesAdded());
  }

  void addToolsTechnologies(String value) {
    if (value.isNotEmpty && !tollsTechnologies.contains(value)) {
      tollsTechnologies.add(value);
      toolController.clear();
      emit(const ToolsAndTechnologiesAdded());
    }
  }

  void removeTool(String tool) {
    if (tool.isNotEmpty) {
      tollsTechnologies.remove(tool);
      emit(const ToolsAndTechnologiesRemoved());
    }
  }

  void addWorkExperience() {
    if (!formKey.currentState!.validate()) return;

    if (tollsTechnologies.isEmpty) {
      emit(const WorkExperienceError('Add at least one tool/technology'));
      return;
    }

    workExperiences.add(WorkExperienceEntity(
      jobTitle: jobTitleController.text,
      companyName: companyNameController.text,
      companyField: companyFieldController.text,
      jobType: selectedJobType!.toUpperCase(),
      jobLocation: selectedJobLocation!.toUpperCase(),
      startDate: startDate!,
      endDate: isCurrentlyWorking ? null : endDate!,
      summary: summaryController.text,
      toolsTechnologiesUsed: List.from(tollsTechnologies),
    ));

    _resetForm();
    emit(const WorkExperienceAdded());
  }

  void removeWorkExperience(WorkExperienceEntity experience) {
    workExperiences.remove(experience);
    emit(const WorkExperienceRemoved());
  }

  void addWorkExperienceBack(WorkExperienceEntity experience) {
    workExperiences.add(experience);
    emit(const WorkExperienceAdded());
  }

  void clearToolSuggestions() {
    filteredToolSuggestions = [];
    emit(const ToolSuggestionsCleared());
  }

  @override
  Future<void> close() {
    jobTitleController.dispose();
    companyNameController.dispose();
    companyFieldController.dispose();
    summaryController.dispose();
    toolController.dispose();
    return super.close();
  }
}
