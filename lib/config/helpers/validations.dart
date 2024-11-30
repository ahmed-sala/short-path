import 'package:flutter/cupertino.dart';

import 'app_regexp.dart';

abstract class Validations {
  static String? validateName(BuildContext context, String? name) {
    if (name!.isEmpty || !AppRegExp.isNameValid(name)) {
      return 'Name is required';
    }
    return null;
  }

  static String? validateEmail(BuildContext context, String? email) {
    if (email!.isEmpty || !AppRegExp.isEmailValid(email)) {
      return 'Email is required!';
    } else if (!email.contains('@')) {
      return 'Invalid Email!';
    }
    return null;
  }

  static String? validatePhoneNumber(
      BuildContext context, String? phoneNumber) {
    if (phoneNumber!.isEmpty || !AppRegExp.isPhoneNumberValid(phoneNumber)) {
      return 'Phone number is required!';
    }
    return null;
  }

  static String? validatePassword(BuildContext context, String? password) {
    if (password!.isEmpty || !AppRegExp.isPasswordValid(password)) {
      return 'Password is required!';
    }
    return null;
  }

  static String? validateConfirmPassword(
      BuildContext context, String? password, String? confirmPassword) {
    if (confirmPassword!.isEmpty ||
        !AppRegExp.isPasswordValid(confirmPassword)) {
      return 'Confirm Password is required!';
    } else if (password != confirmPassword) {
      return 'Password and Confirm Password must be same!';
    }
    return null;
  }

  static String? validateOTP(BuildContext context, String? otp) {
    if (otp!.isEmpty || !AppRegExp.isOTPValid(otp)) {
      return 'OTP is required!';
    }
    return null;
  }

  static String? validateUsername(BuildContext context, String? username) {
    if (username!.isEmpty || !AppRegExp.isUsernameValid(username)) {
      return 'Username is required!';
    }
    return null;
  }
}
