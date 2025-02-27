import 'package:json_annotation/json_annotation.dart';
import 'package:short_path/src/domain/entities/auth/app_user.dart';

part 'get_user_response.g.dart';

@JsonSerializable()
class GetUserResponse {
  @JsonKey(name: "id")
  final int? id;
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
  @JsonKey(name: "role")
  final String? role;

  GetUserResponse({
    this.id,
    this.firstName,
    this.lastName,
    this.mobileNumber,
    this.address,
    this.birthDate,
    this.gender,
    this.email,
    this.role,
  });

  factory GetUserResponse.fromJson(Map<String, dynamic> json) {
    return _$GetUserResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$GetUserResponseToJson(this);
  }

  AppUser toAppUser() {
    return AppUser(
      firstName: firstName,
      lastName: lastName,
      mobileNumber: mobileNumber,
      address: address,
      birthDate: birthDate,
      email: email,
      gender: gender,
    );
  }
}
