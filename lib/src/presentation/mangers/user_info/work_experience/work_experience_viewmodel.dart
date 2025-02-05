import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:short_path/src/domain/entities/user_info/work_experience_entity.dart';
import 'package:short_path/src/presentation/mangers/user_info/work_experience/work_experience_state.dart';

@injectable
class WorkExperienceViewModel extends Cubit<WorkExperienceState> {
  WorkExperienceViewModel() : super(const WorkExperienceInitial()) {
    jobTitleController.addListener(_validateForm);
    companyNameController.addListener(_validateForm);
    companyFieldController.addListener(_validateForm);
    jobTypeController.addListener(_validateForm);
    jobLocationController.addListener(_validateForm);
    summaryController.addListener(_validateForm);
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController jobTitleController = TextEditingController();
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController companyFieldController = TextEditingController();
  final TextEditingController jobTypeController = TextEditingController();
  final TextEditingController jobLocationController = TextEditingController();
  final TextEditingController summaryController = TextEditingController();
  final TextEditingController toolController = TextEditingController();

  DateTime? startDate;
  DateTime? endDate;
  List<WorkExperienceEntity> workExperiences = [];
  List<String> toolsTechnologiesUsed = [];

  bool isValid = false;

  void _validateForm() {
    final bool allFieldsFilled = jobTitleController.text.isNotEmpty &&
        companyNameController.text.isNotEmpty &&
        companyFieldController.text.isNotEmpty &&
        jobTypeController.text.isNotEmpty &&
        jobLocationController.text.isNotEmpty &&
        startDate != null &&
        endDate != null &&
        summaryController.text.isNotEmpty;

    if (isValid != allFieldsFilled) {
      isValid = allFieldsFilled;
      emit(const WorkExperienceChanged()); // Notify UI of state change
    }
  }

  // Validation methods
  String? validateJobTitle(String? value) =>
      value?.isEmpty ?? true ? 'Job Title is required' : null;

  String? validateCompanyName(String? value) =>
      value?.isEmpty ?? true ? 'Company Name is required' : null;

  String? validateCompanyField(String? value) =>
      value?.isEmpty ?? true ? 'Company Field is required' : null;

  String? validateJobType(String? value) =>
      value?.isEmpty ?? true ? 'Job Type is required' : null;

  String? validateJobLocation(String? value) =>
      value?.isEmpty ?? true ? 'Job Location is required' : null;

  String? validateSummary(String? value) =>
      value?.isEmpty ?? true ? 'Summary is required' : null;

  String? validateDates() {
    if (startDate == null) return 'Start date is required';
    if (endDate == null) return 'End date is required';
    if (endDate!.isBefore(startDate!))
      return 'End date must be after start date';
    return null;
  }

  // Date selection
  void selectStartDate(DateTime date) {
    startDate = date;
    emit(StartDateSelected(startDate!));
  }

  void selectEndDate(DateTime date) {
    endDate = date;
    emit(EndDateSelected(endDate!));
  }

  // Tools management
  void addTool(String tool) {
    if (tool.isNotEmpty) {
      toolsTechnologiesUsed.add(tool);
      toolController.clear();
      print(toolsTechnologiesUsed);
      emit(ToolAdded());
    }
  }

  void removeTool(String tool) {
    toolsTechnologiesUsed.remove(tool);
    emit(ToolRemoved());
  }

  // Work experience management
  void addWorkExperience() {
    if (!formKey.currentState!.validate()) return;

    final dateError = validateDates();
    if (dateError != null) {
      emit(WorkExperienceError(dateError));
      return;
    }

    if (toolsTechnologiesUsed.isEmpty) {
      emit(const WorkExperienceError('Add at least one tool/technology'));
      return;
    }

    workExperiences.add(WorkExperienceEntity(
      jobTitle: jobTitleController.text,
      companyName: companyNameController.text,
      companyField: companyFieldController.text,
      jobType: jobTypeController.text,
      jobLocation: jobLocationController.text,
      startDate: DateFormat('M/d/yyyy').format(startDate!),
      endDate: DateFormat('M/d/yyyy').format(endDate!),
      summary: summaryController.text,
      toolsTechnologiesUsed: List.from(toolsTechnologiesUsed),
    ));

    _resetForm();
    emit(const WorkExperienceAdded());
  }

  void _resetForm() {
    jobTitleController.clear();
    companyNameController.clear();
    companyFieldController.clear();
    jobTypeController.clear();
    jobLocationController.clear();
    summaryController.clear();
    toolController.clear();
    toolsTechnologiesUsed.clear();
    startDate = null;
    endDate = null;
    formKey = GlobalKey<FormState>();
  }

  void removeWorkExperience(WorkExperienceEntity experience) {
    workExperiences.remove(experience);
    emit(const WorkExperienceRemoved());
  }

  void addWorkExperienceBack(WorkExperienceEntity experience) {
    workExperiences.add(experience);
    emit(WorkExperienceAdded());
  }

  @override
  Future<void> close() {
    jobTitleController.dispose();
    companyNameController.dispose();
    companyFieldController.dispose();
    jobTypeController.dispose();
    jobLocationController.dispose();
    summaryController.dispose();
    toolController.dispose();
    return super.close();
  }
}
