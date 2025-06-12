import 'package:json_annotation/json_annotation.dart';

part 'interview_preparation_dto.g.dart';

@JsonSerializable()
class InterviewPreparationDto {
  @JsonKey(name: "interviewPreparation")
  final String? interviewPreparation;

  InterviewPreparationDto ({
    this.interviewPreparation,
  });

  factory InterviewPreparationDto.fromJson(Map<String, dynamic> json) {
    return _$InterviewPreparationDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$InterviewPreparationDtoToJson(this);
  }
}


