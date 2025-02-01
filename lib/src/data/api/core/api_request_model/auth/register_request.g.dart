// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterRequest _$RegisterRequestFromJson(Map<String, dynamic> json) =>
    RegisterRequest(
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      mobileNumber: json['mobileNumber'] as String?,
      address: json['address'] as String?,
      birthDate: json['birthDate'] as String?,
      gender: json['gender'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$RegisterRequestToJson(RegisterRequest instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'mobileNumber': instance.mobileNumber,
      'address': instance.address,
      'birthDate': instance.birthDate,
      'gender': instance.gender,
      'email': instance.email,
      'password': instance.password,
    };
