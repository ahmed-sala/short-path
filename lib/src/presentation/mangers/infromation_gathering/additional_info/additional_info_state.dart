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