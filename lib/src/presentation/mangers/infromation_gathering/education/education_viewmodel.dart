import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'education_state.dart';

@injectable
class EducationViewmodel extends Cubit<EducationState> {
  EducationViewmodel() : super(const EducationInitialState());

  final formKey = GlobalKey<FormState>();
  final schoolController = TextEditingController();
  final degreeController = TextEditingController();
  final fieldOfStudyController = TextEditingController();

  DateTime? selectedDate;

  bool validate = false;

  void validateColorButton() {
    // Ensure selectedDate is part of the validation
    if (schoolController.text.isEmpty ||
        degreeController.text.isEmpty ||
        fieldOfStudyController.text.isEmpty ||
        selectedDate == null) {
      // Check if date is selected
      validate = false;
    } else if (!formKey.currentState!.validate()) {
      validate = false;
    } else {
      validate = true;
    }

    emit(ValidateColorButtonState()); // Trigger UI update
  }

  void updateSelectedDate(DateTime date) {
    selectedDate = date;
    print('Selected date: $selectedDate');
    validateColorButton(); // Ensure validation after date selection
  }

  void nextButton() {
    if (formKey.currentState!.validate() && validate) {
      // Navigate to the next screen or process further
      print("Education details submitted successfully.");
    }
  }

  @override
  Future<void> close() {
    schoolController.dispose();
    degreeController.dispose();
    fieldOfStudyController.dispose();
    return super.close();
  }
}
