import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:short_path/core/common/api/api_result.dart';
import 'package:short_path/src/data/api/core/error/error_handler.dart';

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
  final noOfYearsController = TextEditingController();
  final noOfMonthsController = TextEditingController();
  final awardsAndHonorsController = TextEditingController();
  final volunteerWorkDescriptionController = TextEditingController();
  List<VolunteerWorkEntity> volunteerWorkList = [];
  List<String> hobbiesList = [];
  List<String> publicationsList = [];
  List<String> awardsList = [];

  // Form key for validation
  final formKey = GlobalKey<FormState>();

  // Track form validity
  bool _validate = false;
  bool get validate => _validate;

  // List to store additional info entries

  // Validation methods
  String? validateField(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName cannot be empty';
    }
    return null;
  }

  // Validate button color
  void validateColorButton() {
    _validate = formKey.currentState?.validate() ?? false;
    emit(ValidateColorButtonState(validate: _validate));
  }

  Future<void> submitAdditionalInfo() async {
    final additionalInfo = AdditionalInfoEntity(
      hobbiesAndInterests: hobbiesList,
      publications: publicationsList,
      awardsAndHonors: awardsList,
      volunteerWork: volunteerWorkList,
    );
    try {
      emit(AddAdditionalInfoLoading()); // Emit a new state
      var response = await _usecase.invoke(additionalInfo);
      switch (response) {
        case Success<void>():
          emit(AdditionalInfoSuccess()); // Emit a new state
          break;
        case Failures<void>():
          var error = ErrorHandler.fromException(response.exception);
          if (error.code == 401) {
            emit(ExpiredToken());
            return;
          }
          emit(AdditionalInfoError(error.errorMessage)); // Emit a new state
      }
    } catch (e) {
      emit(AdditionalInfoError(e.toString())); // Emit a new state
    }
  }

  void addHobbiesAndInterests(String hobby) {
    if (hobby.isNotEmpty) {
      hobbiesList.add(hobby);
      hobbiesAndInterestsController.clear();
      emit(AdditionalInfoUpdated()); // Emit a new state
    }
  }

  void addPublications(String publication) {
    if (publication.isNotEmpty) {
      publicationsList.add(publication);
      publicationsController.clear();
      emit(AdditionalInfoUpdated()); // Emit a new state
    }
  }

  void addAwardsAndHonors(String award) {
    if (award.isNotEmpty) {
      awardsList.add(award);
      awardsAndHonorsController.clear();
      emit(AdditionalInfoUpdated()); // Emit a new state
    }
  }

  void addVolunteerWork(VolunteerWorkEntity volunteerWork) {
    if (volunteerWork.description.isNotEmpty) {
      volunteerWorkList.add(volunteerWork);
      volunteerWorkDescriptionController.clear();
      noOfMonthsController.clear();
      noOfYearsController.clear();
      emit(AdditionalInfoUpdated()); // Emit a new state
    }
  }

  void removeVolunteerWork(VolunteerWorkEntity volunteerWork) {
    volunteerWorkList.remove(volunteerWork);
    emit(AdditionalInfoUpdated()); // Emit a new state
  }

  void removeHobbiesAndInterests(String hobby) {
    hobbiesList.remove(hobby);
    emit(AdditionalInfoUpdated()); // Emit a new state
  }

  void removePublications(String publication) {
    publicationsList.remove(publication);
    emit(AdditionalInfoUpdated()); // Emit a new state
  }

  void removeAwardsAndHonors(String award) {
    awardsList.remove(award);
    emit(AdditionalInfoUpdated()); // Emit a new state
  }
}
