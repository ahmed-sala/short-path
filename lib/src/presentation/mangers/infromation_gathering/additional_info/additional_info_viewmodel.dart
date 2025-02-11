import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/entities/user_info/additional_info_entity.dart';
import '../../../../domain/usecases/additional_info/additional_info_usecase.dart';
import 'additional_info_state.dart';

@injectable
class AdditionalInfoViewmodel extends Cubit<AdditionalInfoState> {
  final AdditionalInfoUsecase _usecase;

  AdditionalInfoViewmodel(this._usecase) : super(AdditionalInfoInitialState());

  // Controllers for text fields
  final hobbiesAndInterestsController = TextEditingController();
  final publicationsController = TextEditingController();
  final awardsAndHonorsController = TextEditingController();
  final volunteerWorkDescriptionController = TextEditingController();

  // Default values for month and year
  String selectedMonth = 'January'; // Default month
  int selectedYear = DateTime.now().year; // Default year

  // Form key for validation
  final formKey = GlobalKey<FormState>();

  // Track form validity
  bool _validate = false;
  bool get validate => _validate;

  // List to store additional info entries
  List<AdditionalInfoEntity> additionalInfoList = [];

  // Validation methods
  String? validateField(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName cannot be empty';
    }
    return null;
  }

  // Validate a single field and emit a state
  void validateSingleField(String? value, String fieldName) {
    final error = validateField(value, fieldName);
    emit(ValidateSingleFieldState(fieldName, error)); // Emit a new state
  }

  // Set selected month
  void setMonth(String month) {
    selectedMonth = month;
    emit(AdditionalInfoUpdated()); // Emit a new state
  }

  // Set selected year
  void setYear(int year) {
    selectedYear = year;
    emit(AdditionalInfoUpdated()); // Emit a new state
  }

  // Add additional info
  void addAdditionalInfo() {
    if (formKey.currentState?.validate() ?? false) {
      final additionalInfo = AdditionalInfoEntity(
        hobbiesAndInterests: hobbiesAndInterestsController.text,
        publications: publicationsController.text,
        awardsAndHonors: awardsAndHonorsController.text,
        volunteerWork: VolunteerWork(
          description: volunteerWorkDescriptionController.text,
          month: selectedMonth,
          year: selectedYear,
        ),
      );

      additionalInfoList.add(additionalInfo);

      // Clear fields after adding
      hobbiesAndInterestsController.clear();
      publicationsController.clear();
      awardsAndHonorsController.clear();
      volunteerWorkDescriptionController.clear();

      // Invoke the use case
      _usecase.invoke(additionalInfo);

      emit(AdditionalInfoUpdated()); // Emit a new state
    }
  }

  // Remove additional info
  void removeAdditionalInfo(AdditionalInfoEntity additionalInfo) {
    additionalInfoList.remove(additionalInfo);
    _usecase.removeAdditionalInfo(additionalInfo); // Invoke the use case
    emit(AdditionalInfoUpdated()); // Emit a new state
  }

  // Validate button color
  void validateColorButton() {
    _validate = formKey.currentState?.validate() ?? false;
    emit(ValidateColorButtonState(validate: _validate));
  }
}