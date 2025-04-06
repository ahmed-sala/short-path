import 'app_regexp.dart';

String? validateName(String? name) {
  if (name!.isEmpty || !AppRegExp.isNameValid(name)) {
    return 'Name is required';
  }
  return null;
}

String? validateEmail(String? email) {
  if (email!.isEmpty) {
    return 'Email is required!';
  } else if (!AppRegExp.isEmailValid(email)) {
    return 'Invalid Email!';
  }

  return null;
}

String? validateJobTitle(String? jobTitle) {
  if (jobTitle!.isEmpty) {
    return 'Job Title is required!';
  }
  return null;
}

String? validatePhoneNumber(String? phoneNumber) {
  if (phoneNumber!.isEmpty || !AppRegExp.isPhoneNumberValid(phoneNumber)) {
    return 'Phone number is required!';
  }
  return null;
}

String? validatePassword(String? password) {
  if (password!.isEmpty) {
    return 'Password is required!';
  } else if (!AppRegExp.isPasswordValid(password)) {
    return 'Invalid Password!';
  }
  return null;
}

String? validateConfirmPassword(String? password, String? confirmPassword) {
  if (confirmPassword!.isEmpty || !AppRegExp.isPasswordValid(confirmPassword)) {
    return 'Confirm Password is required!';
  } else if (password != confirmPassword) {
    return 'Password and Confirm Password must be same!';
  }
  return null;
}

String? validateOTP(String? otp) {
  if (otp!.isEmpty || !AppRegExp.isOTPValid(otp)) {
    return 'OTP is required!';
  }
  return null;
}

String? validateUsername(String? username) {
  if (username!.isEmpty || !AppRegExp.isUsernameValid(username)) {
    return 'Username is required!';
  }
  return null;
}

String? validateAddress(String? address) {
  if (address!.isEmpty) {
    return 'Address is required!';
  }
  return null;
}

String? validateProjectName(String? value) =>
    (value == null || value.isEmpty) ? 'Project Name is required' : null;

String? validateProjectDescription(String? value) =>
    (value == null || value.isEmpty) ? 'Project Description is required' : null;

String? validateLink(String? value) {
  if (value == null || value.isEmpty) {
    return 'Link is required';
  }
  return null;
}

String? validateCertificationName(String? value) {
  if (value == null || value.isEmpty) {
    return 'Certification Name cannot be empty';
  }
  return null;
}

String? validateIssuingOrganization(String? value) {
  if (value == null || value.isEmpty) {
    return 'Issuing Organization cannot be empty';
  }
  return null;
}

String? validateJobType(String? value) =>
    (value == null || value.isEmpty) ? 'Job Type is required' : null;

String? validateJobLocation(String? value) =>
    (value == null || value.isEmpty) ? 'Job Location is required' : null;

String? validateSummary(String? value) =>
    value?.isEmpty ?? true ? 'Summary is required' : null;

String? validateDates(
    DateTime? startDate, DateTime? endDate, bool isCurrentlyWorking) {
  if (startDate == null) return 'Start date is required';
  if (!isCurrentlyWorking) {
    if (endDate == null) return 'End date is required';
    if (endDate.isBefore(startDate)) {
      return 'End date must be after start date';
    }
  }
  return null;
}

String? validateRole(String? value) =>
    (value == null || value.isEmpty) ? 'Role is required' : null;

String? validateDegree(String? value) =>
    (value == null || value.isEmpty) ? 'Degree is required' : null;

String? validateFieldOfStudy(String? value) =>
    (value == null || value.isEmpty) ? 'Field of Study is required' : null;

String? validateSchool(String? value) =>
    (value == null || value.isEmpty) ? 'School is required' : null;

String? validateGrade(String? value) =>
    (value == null || value.isEmpty) ? 'Grade is required' : null;

String? validateCompanyName(String? value) =>
    (value == null) ? 'Company Name is required' : null;

String? validateCompanyField(String? value) =>
    (value == null) ? 'Company Field is required' : null;

String? validateTool(String? value) =>
    (value == null || value.isEmpty) ? 'Tool is required' : null;
