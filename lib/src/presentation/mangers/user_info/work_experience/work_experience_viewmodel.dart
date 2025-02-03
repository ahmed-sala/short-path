import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:short_path/src/domain/entities/user_info/work_experience_entity.dart';
import 'package:short_path/src/domain/usecases/user_info/user_info_usecase.dart';

part 'work_experience_state.dart';

@injectable
@singleton
class WorkExperienceViewModel extends Cubit<WorkExperienceState> {
  final UserInfoUsecase userInfoUseCase;
  WorkExperienceViewModel(this.userInfoUseCase) : super(WorkExperienceInitial()) {
    /// **Attach listeners to text controllers**
    jobTitleController.addListener(onTextChanged);
    companyNameController.addListener(onTextChanged);
    companyFieldController.addListener(onTextChanged);
    jobTypeController.addListener(onTextChanged);
    jobLocationController.addListener(onTextChanged);
    startDateController.addListener(onTextChanged);
    endDateController.addListener(onTextChanged);
    summaryController.addListener(onTextChanged);
  }

  final formKey = GlobalKey<FormState>();
  final TextEditingController jobTitleController = TextEditingController();
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController companyFieldController = TextEditingController();
  final TextEditingController jobTypeController = TextEditingController();
  final TextEditingController jobLocationController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController summaryController = TextEditingController();
  final TextEditingController toolController = TextEditingController();

  List<WorkExperienceEntity> workExperiences = [];
  List<String> toolsTechnologiesUsed = [];
  bool isValid  = false;



  /// **Listen for Text Changes & Validate Form**
  void onTextChanged() {
    final bool allFieldsFilled = jobTitleController.text.isNotEmpty &&
        companyNameController.text.isNotEmpty &&
        companyFieldController.text.isNotEmpty &&
        jobTypeController.text.isNotEmpty &&
        jobLocationController.text.isNotEmpty &&
        startDateController.text.isNotEmpty &&
        endDateController.text.isNotEmpty &&
        summaryController.text.isNotEmpty;

    if (isValid != allFieldsFilled) {
      isValid = allFieldsFilled;
      emit(const WorkExperienceChanged()); // Notify UI of state change
    }
  }

  /// **Add Tool/Technology**
  void addTool(String tool) {
    if (tool.isNotEmpty && !toolsTechnologiesUsed.contains(tool)) {
      toolsTechnologiesUsed.add(tool);
      emit(ToolAdded(tool));
    }
  }

  /// **Remove Tool/Technology**
  void removeTool(String tool) {
    toolsTechnologiesUsed.remove(tool);
    emit(ToolRemoved(tool));
  }

  /// **Add Work Experience**
  void addWorkExperience() {
    if (!formKey.currentState!.validate()) {
      emit(const WorkExperienceError("Please fill in all required fields."));
      return;
    }

    final workExperience = WorkExperienceEntity(
      jobTitle: jobTitleController.text,
      companyName: companyNameController.text,
      companyField: companyFieldController.text,
      jobType: jobTypeController.text,
      jobLocation: jobLocationController.text,
      startDate: startDateController.text,
      endDate: endDateController.text,
      summary: summaryController.text,
      toolsTechnologiesUsed: toolsTechnologiesUsed,
    );

    workExperiences.add(workExperience);
    emit(WorkExperienceAdded(workExperience));
  }

  /// **Remove Work Experience**
  void removeWorkExperience(WorkExperienceEntity workExperience) {
    workExperiences.remove(workExperience);
    emit(WorkExperienceRemoved(workExperience));
  }

  @override
  Future<void> close() {
    jobTitleController.dispose();
    companyNameController.dispose();
    companyFieldController.dispose();
    jobTypeController.dispose();
    jobLocationController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    summaryController.dispose();
    toolController.dispose();
    return super.close();
  }
}
