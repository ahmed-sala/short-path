import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:short_path/core/common/api/api_result.dart';
import 'package:short_path/src/data/api/core/error/error_handler.dart';

import '../../../../domain/entities/user_info/Project_Entity.dart';
import '../../../../domain/usecases/Project/project_usecase.dart';
import 'Project_State.dart';

@injectable
@singleton
class ProjectViewmodel extends Cubit<ProjectState> {
  ProjectViewmodel(this.projectUsecase) : super(ProjectInitialState()) {
    // Add a listener to the technologiesUsedController
    technologiesUsedController.addListener(onToolChanged);
  }

  final ProjectUsecase projectUsecase;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController projectTitleController = TextEditingController();
  final TextEditingController projectLinkController = TextEditingController();
  final TextEditingController roleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController technologiesUsedController = TextEditingController();

  List<ProjectEntity> projects = [];
  List<String> toolsTechnologies = [];
  List<String> filteredToolSuggestions = [];
  bool validate = false;

  String? role;

  final List<String> suggestedTechnologies = [
    'Flutter',
    'Dart',
    'React',
    'Angular',
    'Vue.js',
    'Node.js',
    'Python',
    'Java',
    'C#',
    'JavaScript',
    'TypeScript',
    'Swift',
    'Kotlin',
    'Go',
    'Ruby',
    'PHP',
    'SQL',
    'MongoDB',
    'Firebase',
    'AWS',
    'Docker',
    'Kubernetes',
    'Git',
    'Jenkins',
    'CI/CD',
  ];

  String? validateProjectTitle(String? value) {
    return (value == null || value.trim().isEmpty) ? 'Project Title is required' : null;
  }

  String? validateProjectLink(String? value) {
    return (value == null || value.trim().isEmpty) ? 'Project Link is required' : null;
  }

  String? validateRole(String? value) {
    return (value == null || value.trim().isEmpty) ? 'Role is required' : null;
  }

  String? validateDescription(String? value) {
    return (value == null || value.trim().isEmpty) ? 'Description is required' : null;
  }

  String? validateTechnologiesUsed(String? value) {
    return (value == null || value.trim().isEmpty) ? 'Technologies Used are required' : null;
  }

  void addProject() {
    if (formKey.currentState?.validate() ?? false) {
      final project = ProjectEntity(
        projectTitle: projectTitleController.text.trim(),
        role: role ?? '',
        description: descriptionController.text.trim(),
        technologiesUsed: toolsTechnologies.join(', '),
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
    technologiesUsedController.text = selectedTool; // Set the text to the selected tool
    addToolsTechnologies(selectedTool); // Add the selected tool to toolsTechnologies
    filteredToolSuggestions = []; // Clear the suggestions list
    emit(ProjectUpdated()); // Notify the UI to rebuild
  }

  void onToolChanged() {
    filteredToolSuggestions = technologiesUsedController.text.isEmpty
        ? suggestedTechnologies
        : suggestedTechnologies
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
        var response = await projectUsecase.invoke(ProjectsEntity(projects: projects));
        switch (response) {
          case Success<void>():
            emit(AddProjectSuccess());
            break;
          case Failures<void>():
            var errorMessage = ErrorHandler.fromException(response.exception).errorMessage;
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
  }

  @override
  Future<void> close() {
    technologiesUsedController.removeListener(onToolChanged); // Remove the listener
    projectTitleController.dispose();
    roleController.dispose();
    descriptionController.dispose();
    technologiesUsedController.dispose();
    projectLinkController.dispose();
    return super.close();
  }
}