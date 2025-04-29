import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/entities/home/jobs_entity.dart';

part 'jobs_response.g.dart';

@JsonSerializable()
class JobsResponse {
  @JsonKey(name: "content")
  final List<Content>? content;
  @JsonKey(name: "pageNumber")
  final int? pageNumber;
  @JsonKey(name: "pageSize")
  final int? pageSize;
  @JsonKey(name: "totalElements")
  final int? totalElements;
  @JsonKey(name: "totalPages")
  final int? totalPages;
  @JsonKey(name: "last")
  final bool? last;
  @JsonKey(name: "fullTimeJobsCount")
  final int? fullTimeJobsCount;
  @JsonKey(name: "partTimeJobsCount")
  final int? partTimeJobsCount;
  @JsonKey(name: "internshipJobsCount")
  final int? internshipJobsCount;

  JobsResponse({
    this.content,
    this.pageNumber,
    this.pageSize,
    this.totalElements,
    this.totalPages,
    this.last,
    this.fullTimeJobsCount,
    this.partTimeJobsCount,
    this.internshipJobsCount,
  });

  factory JobsResponse.fromJson(Map<String, dynamic> json) {
    return _$JobsResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$JobsResponseToJson(this);
  }

  JobEntity toEntity() {
    return JobEntity(
      content: content?.map((e) => e.toEntity()).toList(),
      pageNumber: pageNumber,
      pageSize: pageSize,
      totalElements: totalElements,
      totalPages: totalPages,
      last: last,
      fullTimeJobsCount: fullTimeJobsCount,
      partTimeJobsCount: partTimeJobsCount,
      internshipJobsCount: internshipJobsCount,
    );
  }
}

@JsonSerializable()
class Content {
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

  Content({
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

  factory Content.fromJson(Map<String, dynamic> json) {
    return _$ContentFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ContentToJson(this);
  }

  ContentEntity toEntity() {
    return ContentEntity(
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
