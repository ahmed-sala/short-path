import 'package:json_annotation/json_annotation.dart';
import 'package:short_path/src/domain/entities/home/job_entity.dart';

part 'jobs_response.g.dart';

@JsonSerializable()
class JobsResponse {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "title")
  final String? title;
  @JsonKey(name: "company")
  final String? company;
  @JsonKey(name: "description")
  final String? description;
  @JsonKey(name: "image")
  final String? image;
  @JsonKey(name: "location")
  final String? location;
  @JsonKey(name: "employmentType")
  final String? employmentType;
  @JsonKey(name: "datePosted")
  final String? datePosted;
  @JsonKey(name: "salaryRange")
  final String? salaryRange;
  @JsonKey(name: "url")
  final String? url;

  JobsResponse({
    this.id,
    this.title,
    this.company,
    this.description,
    this.image,
    this.location,
    this.employmentType,
    this.datePosted,
    this.salaryRange,
    this.url,
  });

  factory JobsResponse.fromJson(Map<String, dynamic> json) {
    return _$JobsResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$JobsResponseToJson(this);
  }

  JobEntity toEntity() {
    return JobEntity(
      id: id,
      title: title,
      company: company,
      description: description,
      image: image,
      location: location,
      employmentType: employmentType,
      datePosted: datePosted,
      salaryRange: salaryRange,
      url: url,
    );
  }
}
