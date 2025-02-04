import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../domain/entities/infromation_gathering/EducationProject_Entity.dart';
import '../../../../domain/usecases/EducationProjectUsecase/educationProject_usecase.dart';
import 'EducationProjectState.dart';

@injectable
@singleton
class EducationProjectViewmodel extends Cubit<EducationProjectState> {
  EducationProjectViewmodel(this.educationProjectUsecase)
      : super(EducationProjectInitialState()) {
    // Attach listeners to controllers
    projectNameController.addListener(onInputChanged);
    projectDescriptionController.addListener(onInputChanged);
    projectLinkController.addListener(onInputChanged);
    toolsTechnologiesController.addListener(onInputChanged);
  }

  final EducationProjectUsecase educationProjectUsecase;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController projectNameController = TextEditingController();
  final TextEditingController projectDescriptionController = TextEditingController();
  final TextEditingController projectLinkController = TextEditingController();
  final TextEditingController toolsTechnologiesController = TextEditingController();

  List<EducationProjectEntity> projects = []; // List to store projects
  bool validate = false;

  void onInputChanged() {
    validateColorButton();
  }

  String? validateProjectName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Project Name is required';
    }
    return null;
  }

  String? validateProjectDescription(String? value) {
    if (value == null || value.isEmpty) {
      return 'Project Description is required';
    }
    return null;
  }

  String? validateProjectLink(String? value) {
    if (value == null || value.isEmpty) {
      return 'Project Link is required';
    }
    return null;
  }

  String? validateToolsTechnologies(String? value) {
    if (value == null || value.isEmpty) {
      return 'Tools/Technologies are required';
    }
    return null;
  }

  void addProject() {
    if (formKey.currentState!.validate()) {
      final project = EducationProjectEntity(
        projectName: projectNameController.text,
        projectDescription: projectDescriptionController.text,
        projectLink: projectLinkController.text,
        toolsTechnologies: toolsTechnologiesController.text,
      );

      projects.add(project);

      // Clear input fields
      projectNameController.clear();
      projectDescriptionController.clear();
      projectLinkController.clear();
      toolsTechnologiesController.clear();

      emit(EducationProjectUpdated()); // Update UI
    }
  }

  void removeProject(EducationProjectEntity project) {
    projects.remove(project);
    emit(EducationProjectUpdated()); // Update UI
  }

  void addProjectBack(EducationProjectEntity project) {
    projects.add(project);
    emit(EducationProjectUpdated()); // Notify UI about the change
  }

  void next() {
    if (projects.isNotEmpty) {
      for (var project in projects) {
        educationProjectUsecase.invoke(project);
      }
      emit(EducationProjectUpdated());
    }
  }

  void validateColorButton() {
    validate = projectNameController.text.isNotEmpty &&
        projectDescriptionController.text.isNotEmpty &&
        projectLinkController.text.isNotEmpty &&
        toolsTechnologiesController.text.isNotEmpty &&
        formKey.currentState?.validate() == true;

    emit(ValidateColorButtonState(validate: validate));
  }

  @override
  Future<void> close() {
    projectNameController.dispose();
    projectDescriptionController.dispose();
    projectLinkController.dispose();
    toolsTechnologiesController.dispose();
    return super.close();
  }
}
