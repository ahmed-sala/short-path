import 'package:short_path/src/data/dto_models/auth/app_user_dto.dart';

class AppUser {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String mobileNumber;
  final String birthDate;
  final String gender;
  final String address;

  AppUser({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.mobileNumber,
    required this.birthDate,
    required this.gender,
    required this.address,
  });
  AppUserDto toAppUserDto() {
    return AppUserDto(
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
