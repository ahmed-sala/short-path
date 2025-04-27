import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:short_path/core/common/api/api_result.dart';
import 'package:short_path/src/data/api/core/error/error_handler.dart';

import '../../../../domain/entities/user_info/Certification_Entity.dart';
import '../../../../domain/usecases/Certification/certification_usecase.dart';
import 'certification_state.dart';

@injectable
class CertificationViewmodel extends Cubit<CertificationState> {
  final CertificationUsecase _usecase;

  CertificationViewmodel(this._usecase) : super(const CertificationInitialState());

  // Text controllers for certification details
  final certificationNameController = TextEditingController();
  final issuingOrganizationController = TextEditingController();

  // Date selections
  DateTime? selectedDateEarned;
  DateTime? selectedExpirationDate;

  final formKey = GlobalKey<FormState>();

  List<CertificationEntity> certifications = [];

  // Validation methods for fields

  // Set the selected date for Date Earned
  void setDateEarned(DateTime date) {
    selectedDateEarned = date;
    emit(const DateEarnedChanged());
  }

  // Set the selected date for Expiration Date
  void setExpirationDate(DateTime date) {
    selectedExpirationDate = date;
    emit(ExpirationDateChanged(date));
    validateColorButton();
  }

  // Add Certification logic
  void addCertification() {
    if (formKey.currentState?.validate() ?? false) {
      final certification = CertificationEntity(
        certificationName: certificationNameController.text,
        issuingOrganization: issuingOrganizationController.text,
        dateEarned: selectedDateEarned,
        expirationDate: selectedExpirationDate,
      );

      certifications.add(certification);

      // Clear the fields after adding certification
      certificationNameController.clear();
      issuingOrganizationController.clear();
      selectedDateEarned = null;
      selectedExpirationDate = null;

      emit(const CertificationUpdated());
    }
  }

  void next() async {
    if (certifications.isEmpty) {
      emit(const AddCertificationsFailure(
          message: 'Please add at least one certification'));
    } else {
      emit(const AddCertificationsLoading());
      try {
        final result = await _usecase.addCertification(
            CertificationsEntity(certifications: certifications));
        switch (result) {
          case Success<void>():
            emit(const AddCertificationsSuccess());
          case Failures<void>():
            var errorMessage =
                ErrorHandler.fromException(result.exception).errorMessage;
            emit(AddCertificationsFailure(message: errorMessage));
        }
      } catch (e) {
        emit(const AddCertificationsFailure(message: 'An error occurred'));
      }
    }
  }

  // Remove Certification logic
  void removeCertification(CertificationEntity certification) {
    certifications.remove(certification);
    _usecase.removeCertification(certification);
    emit(const CertificationUpdated());
  }

  // Add Certification Back (Undo Removal)
  void addCertificationBack(CertificationEntity certification) {
    certifications.add(certification);
    emit(const CertificationUpdated());
  }

  // Method to validate the color of the button
  void validateColorButton() {
    bool isValid = formKey.currentState?.validate() ?? false;
    emit(ValidateColorButtonState(validate: isValid));
  }

  // Update Certification Name
  void updateCertificationName(String value) {
    emit(const CertificationNameChanged());
  }

  // Update Issuing Organization
  void updateIssuingOrganization(String value) {
    emit(const IssuingOrganizationChanged());
  }
}
