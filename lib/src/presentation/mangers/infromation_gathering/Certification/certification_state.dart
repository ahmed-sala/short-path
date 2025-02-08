sealed class CertificationState {
  const CertificationState();
}

class CertificationInitialState extends CertificationState {
  const CertificationInitialState();
}

class CertificationLoading extends CertificationState {
  const CertificationLoading();
}

class CertificationUpdated extends CertificationState {
  const CertificationUpdated();
}

class CertificationNameChanged extends CertificationState {
  const CertificationNameChanged();
}

class IssuingOrganizationChanged extends CertificationState {
  const IssuingOrganizationChanged();
}

class DateEarnedChanged extends CertificationState {
  const DateEarnedChanged();
}

class ExpirationDateChanged extends CertificationState {
  final DateTime? date;
  const ExpirationDateChanged(this.date);
}

class ValidateColorButtonState extends CertificationState {
  final bool validate;
  const ValidateColorButtonState({required this.validate});
}

class AddCertificationsSuccess extends CertificationState {
  const AddCertificationsSuccess();
}

class AddCertificationsFailure extends CertificationState {
  final String message;
  const AddCertificationsFailure({required this.message});
}

class AddCertificationsLoading extends CertificationState {
  const AddCertificationsLoading();
}
