import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../domain/entities/user_info/additional_info_entity.dart';
import 'additional_info_state.dart';

@injectable
class AdditionalInfoViewmodel extends Cubit<AdditionalInfoState> {
  AdditionalInfoViewmodel() : super(const AdditionalInfoInitialState());

  // Controllers for text fields
  final hobbiesAndInterestsController = TextEditingController();
  final publicationsController = TextEditingController();
  final awardsAndHonorsController = TextEditingController();
  final volunteerWorkDescriptionController = TextEditingController();
  String selectedMonth = 'January'; // Default month
  int selectedYear = DateTime.now().year; // Default year

  final formKey = GlobalKey<FormState>();

  List<AdditionalInfoEntity> additionalInfoList = [];

  // Validation methods
  String? validateField(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName cannot be empty';
    }
    return null;
  }

  // Set selected month
  void setMonth(String month) {
    selectedMonth = month;
    emit(const AdditionalInfoUpdated());
  }

  // Set selected year
  void setYear(int year) {
    selectedYear = year;
    emit(const AdditionalInfoUpdated());
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

      emit(const AdditionalInfoUpdated());
    }
  }

  // Remove additional info
  void removeAdditionalInfo(AdditionalInfoEntity additionalInfo) {
    print('Removing item: ${additionalInfo.hobbiesAndInterests}'); // Debug
    additionalInfoList = List.from(additionalInfoList)..remove(additionalInfo); // Force new list reference
    print('List length after removal: ${additionalInfoList.length}'); // Debug
    emit(const AdditionalInfoUpdated()); // Emit a new state
  }

  // Validate button color
  void validateColorButton() {
    bool isValid = formKey.currentState?.validate() ?? false;
    emit(ValidateColorButtonState(validate: isValid));
  }
}