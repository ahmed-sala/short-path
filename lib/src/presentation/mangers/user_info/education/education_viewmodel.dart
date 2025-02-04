import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:short_path/src/domain/entities/user_info/education_detail_entity.dart';

import '../../../screens/screen/user info/education_screen/education_projects_screen.dart';
import '../../../screens/screen/user info/education_screen/education_screen.dart';
import 'education_state.dart';

@injectable
class EducationViewmodelNew extends Cubit<EducationState> {
  EducationViewmodelNew() : super(const EducationInitialState());
  List<EducationDetailEntity> educationDetails = [];
  final formKey = GlobalKey<FormState>();
  final institutionName = TextEditingController();
  final degreeCertification = TextEditingController();
  final location = TextEditingController();
  int currentPage = 0;

  DateTime? selectedDate;

  bool validate = false;
  var pages = [
    EducationScreen(),
    EducationProjectsScreen(),
  ];
  void validateColorButton() {
    if (institutionName.text.isEmpty ||
        degreeCertification.text.isEmpty ||
        location.text.isEmpty) {
      validate = false;
    } else if (!formKey.currentState!.validate()) {
      {
        validate = false;
      }
    } else {
      validate = true;
    }
  }

  void updateSelectedDate(DateTime date) {
    selectedDate = date;
    emit(
        UpdateSelectedDateState(selectedDate)); // Emit state to trigger rebuild
    validateColorButton(); // Ensure validation after date selection
  }

  void nextButton() {
    if (validate) {
      // Already validated, no need to check again
      print("Education details submitted successfully.");
    }
  }

  void removeEducation(EducationDetailEntity education) {
    educationDetails = List.from(educationDetails)..remove(education);
    emit(RemoveEducationState());
  }

  void addEducation() {
    changePage(0);
    print(educationDetails);

    educationDetails.add(EducationDetailEntity(
      degreeCertification: degreeCertification.text,
      institutionName: institutionName.text,
      location: location.text,
      graduationDate: selectedDate.toString(),
    ));
    emit(const EducationAddedState());

    // Clear the form fields and reset the date
    institutionName.clear();
    degreeCertification.clear();
    location.clear();
    selectedDate = null;
  }

  void changePage(int index) {
    if (currentPage != index) {
      // Prevent unnecessary rebuilds
      currentPage = index;
      emit(OnboardingNextState());
    }
  }

  void returnToPreviousPage() {
    changePage(0);
  }

  void dataDispose() {
    institutionName.dispose();
    degreeCertification.dispose();
    location.dispose();
  }

  @override
  Future<void> close() {
    institutionName.dispose();
    degreeCertification.dispose();
    location.dispose();
    return super.close();
  }
}
