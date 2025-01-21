import 'package:json_annotation/json_annotation.dart';

part 'auth_response.g.dart';

@JsonSerializable()
class AuthResponse {
  @JsonKey(name: "token")
  final String? token;

  AuthResponse({
    this.token,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return _$AuthResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AuthResponseToJson(this);
  }
}
