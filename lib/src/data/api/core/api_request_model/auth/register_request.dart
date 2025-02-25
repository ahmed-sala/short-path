import 'package:json_annotation/json_annotation.dart';
import 'package:short_path/src/data/dto_models/auth/app_user_dto.dart';

part 'register_request.g.dart';

@JsonSerializable()
class RegisterRequest {
  @JsonKey(name: "firstName")
  final String? firstName;
  @JsonKey(name: "lastName")
  final String? lastName;
  @JsonKey(name: "mobileNumber")
  final String? mobileNumber;
  @JsonKey(name: "address")
  final String? address;
  @JsonKey(name: "birthDate")
  final String? birthDate;
  @JsonKey(name: "gender")
  final String? gender;
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "password")
  final String? password;

  RegisterRequest({
    this.firstName,
    this.lastName,
    this.mobileNumber,
    this.address,
    this.birthDate,
    this.gender,
    this.email,
    this.password,
  });

  factory RegisterRequest.fromJson(Map<String, dynamic> json) {
    return _$RegisterRequestFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$RegisterRequestToJson(this);
  }

  AppUserDto toAppUserDto() {
    return AppUserDto(
        firstName: firstName!,
        lastName: lastName!,
        email: email!,
        address: address!,
        password: password!,
        mobileNumber: mobileNumber!,
        birthDate: birthDate!,
        gender: gender!);
  }
}
