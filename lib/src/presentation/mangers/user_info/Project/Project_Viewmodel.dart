import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:short_path/core/common/api/api_result.dart';
import 'package:short_path/src/data/api/core/error/error_handler.dart';
import 'package:short_path/src/data/static_data/demo_data_list.dart';

import '../../../../domain/entities/user_info/Project_Entity.dart';
import '../../../../domain/usecases/Project/project_usecase.dart';
import 'Project_State.dart';

@injectable
class ProjectViewmodel extends Cubit<ProjectState> {
  ProjectViewmodel(this.projectUsecase) : super(ProjectInitialState()) {
    // Add a listener to the technologiesUsedController
    technologiesUsedController.addListener(onToolChanged);
  }

  final ProjectUsecase projectUsecase;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController projectTitleController = TextEditingController();
  final TextEditingController projectLinkController = TextEditingController();
  final TextEditingController roleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController technologiesUsedController =
      TextEditingController();

  List<ProjectEntity> projects = [];
  List<String> toolsTechnologies = [];
  List<String> filteredToolSuggestions = [];
  bool validate = false;

  String? role;

  // When the add button is pressed for the project, if the technologies field still has a value, add it
  void addProject() {
    if (formKey.currentState?.validate() ?? false) {
      // Check if there is a tool left in the text field that hasn't been added
      final currentTool = technologiesUsedController.text.trim();
      if (currentTool.isNotEmpty && !toolsTechnologies.contains(currentTool)) {
        toolsTechnologies.add(currentTool);
      }

      final project = ProjectEntity(
        projectTitle: projectTitleController.text.trim(),
        role: roleController.text.trim(),
        description: descriptionController.text.trim(),
        technologiesUsed:
            List.from(toolsTechnologies), // copy list to avoid future mutations
        projectLink: projectLinkController.text.trim(),
      );

      projects.add(project);
      _clearFields();
      emit(ProjectUpdated());
    }
  }

  void removeProject(ProjectEntity project) {
    projects.remove(project);
    emit(ProjectUpdated());
  }

  void addProjectBack(ProjectEntity project) {
    projects.add(project);
    emit(ProjectUpdated());
  }

  void addToolsTechnologies(String value) {
    if (value.isNotEmpty && !toolsTechnologies.contains(value)) {
      toolsTechnologies.add(value);
      technologiesUsedController.clear();
      emit(ProjectUpdated());
    }
  }

  void removeToolsTechnologies(String value) {
    toolsTechnologies.remove(value);
    emit(ProjectUpdated());
  }

  void selectTool(int index) {
    final selectedTool = filteredToolSuggestions[index];
    technologiesUsedController.text =
        selectedTool; // Set the text to the selected tool
    addToolsTechnologies(
        selectedTool); // Add the selected tool to toolsTechnologies
    filteredToolSuggestions = []; // Clear the suggestions list
    emit(ProjectUpdated()); // Notify the UI to rebuild
  }

  void onToolChanged() {
    filteredToolSuggestions = technologiesUsedController.text.isEmpty
        ? technicalSkills
        : technicalSkills
            .where((tool) => tool
                .toLowerCase()
                .startsWith(technologiesUsedController.text.toLowerCase()))
            .toList();
    emit(ProjectUpdated());
  }

  void validateColorButton() {
    bool newValidate = formKey.currentState?.validate() ?? false;
    if (newValidate != validate) {
      validate = newValidate;
      emit(ValidateColorButtonState(validate: validate));
    }
  }

  void next() async {
    if (projects.isNotEmpty) {
      try {
        emit(AddProjectLoading());
        var response =
            await projectUsecase.invoke(ProjectsEntity(projects: projects));
        switch (response) {
          case Success<void>():
            emit(AddProjectSuccess());
            break;
          case Failures<void>():
            var errorMessage =
                ErrorHandler.fromException(response.exception).errorMessage;
            emit(AddProjectFailure(error: errorMessage));
        }
      } catch (e) {
        emit(AddProjectFailure(error: e.toString()));
      }
    }
  }

  void _clearFields() {
    projectTitleController.clear();
    roleController.clear();
    descriptionController.clear();
    technologiesUsedController.clear();
    projectLinkController.clear();
    toolsTechnologies.clear();
    formKey = GlobalKey<FormState>();
  }

  @override
  Future<void> close() {
    technologiesUsedController
        .removeListener(onToolChanged); // Remove the listener
    projectTitleController.dispose();
    roleController.dispose();
    descriptionController.dispose();
    technologiesUsedController.dispose();
    projectLinkController.dispose();
    return super.close();
  }
}
