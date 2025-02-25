import 'package:short_path/src/data/api/core/api_request_model/auth/register_request.dart';
import 'package:short_path/src/domain/entities/auth/app_user.dart';

class AppUserDto {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? password;
  final String? mobileNumber;
  final String? birthDate;
  final String? gender;
  final String? address;

  AppUserDto({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.mobileNumber,
    required this.birthDate,
    required this.gender,
    required this.address,
  });
  RegisterRequest toRegisterRequest() {
    return RegisterRequest(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
        mobileNumber: mobileNumber,
        birthDate: birthDate,
        address: address,
        gender: gender);
  }

  AppUser toAppUser() {
    return AppUser(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
        mobileNumber: mobileNumber,
        birthDate: birthDate,
        address: address,
        gender: gender);
  }
}
