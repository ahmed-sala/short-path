sealed class AdditionalInfoState {
  const AdditionalInfoState();
}

class AdditionalInfoInitialState extends AdditionalInfoState {
  const AdditionalInfoInitialState();
}

class AdditionalInfoUpdated extends AdditionalInfoState {
  const AdditionalInfoUpdated();
}

class ValidateColorButtonState extends AdditionalInfoState {
  final bool validate;
  const ValidateColorButtonState({required this.validate});
}

class ValidateSingleFieldState extends AdditionalInfoState {
  final String fieldName;
  final String? error;
  const ValidateSingleFieldState(this.fieldName, this.error);
}

class AddAdditionalInfoLoading extends AdditionalInfoState {
  const AddAdditionalInfoLoading();
}

class AdditionalInfoSuccess extends AdditionalInfoState {
  const AdditionalInfoSuccess();
}

class AdditionalInfoError extends AdditionalInfoState {
  final String message;
  const AdditionalInfoError(this.message);
}

class ExpiredToken extends AdditionalInfoState {
  const ExpiredToken();
}
