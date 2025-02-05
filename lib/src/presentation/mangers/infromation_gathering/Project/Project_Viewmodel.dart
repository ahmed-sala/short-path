import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/entities/user_info/Project_Entity.dart';
import '../../../../domain/usecases/Project/project_usecase.dart';
import 'Project_State.dart';

@injectable
@singleton
class ProjectViewmodel extends Cubit<ProjectState> {
  ProjectViewmodel(this.projectUsecase) : super(ProjectInitialState()) {
    _attachListeners();
  }

  final ProjectUsecase projectUsecase;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController projectTitleController = TextEditingController();
  final TextEditingController roleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController technologiesUsedController =
      TextEditingController();

  List<ProjectEntity> projects = []; // List to store projects
  bool validate = false;

  void _attachListeners() {
    projectTitleController.addListener(validateColorButton);
    roleController.addListener(validateColorButton);
    descriptionController.addListener(validateColorButton);
    technologiesUsedController.addListener(validateColorButton);
  }

  String? validateProjectTitle(String? value) {
    return (value == null || value.trim().isEmpty)
        ? 'Project Title is required'
        : null;
  }

  String? validateRole(String? value) {
    return (value == null || value.trim().isEmpty) ? 'Role is required' : null;
  }

  String? validateDescription(String? value) {
    return (value == null || value.trim().isEmpty)
        ? 'Description is required'
        : null;
  }

  String? validateTechnologiesUsed(String? value) {
    return (value == null || value.trim().isEmpty)
        ? 'Technologies Used are required'
        : null;
  }

  void addProject() {
    if (formKey.currentState?.validate() ?? false) {
      final project = ProjectEntity(
        projectTitle: projectTitleController.text.trim(),
        role: roleController.text.trim(),
        description: descriptionController.text.trim(),
        technologiesUsed: technologiesUsedController.text.trim(),
      );

      projects.add(project);
      _clearFields();
      emit(ProjectUpdated()); // Notify UI
    }
  }

  void removeProject(ProjectEntity project) {
    projects.remove(project);
    emit(ProjectUpdated()); // Notify UI
  }

  void addProjectBack(ProjectEntity project) {
    projects.add(project);
    emit(ProjectUpdated()); // Notify UI
  }

  void next() {
    if (projects.isNotEmpty) {
      for (var project in projects) {
        projectUsecase.invoke(project);
      }
      emit(ProjectUpdated());
    }
  }

  void validateColorButton() {
    bool newValidate = formKey.currentState?.validate() ?? false;
    if (newValidate != validate) {
      validate = newValidate;
      emit(ValidateColorButtonState(validate: validate));
    }
  }

  void _clearFields() {
    projectTitleController.clear();
    roleController.clear();
    descriptionController.clear();
    technologiesUsedController.clear();
    validateColorButton(); // Revalidate after clearing fields
  }

  @override
  Future<void> close() {
    projectTitleController.dispose();
    roleController.dispose();
    descriptionController.dispose();
    technologiesUsedController.dispose();
    return super.close();
  }
}
